package FightModule.panel
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import FightModule.behaviors.CellAddBehavior;
	import FightModule.behaviors.CellRemoveBehavior;
	import FightModule.behaviors.MoveBehavior;
	import FightModule.element.CellItem;
	import FightModule.model.AnimationModel;
	import FightModule.model.CellInfo;
	import FightModule.model.FightConst;
	import FightModule.model.GridModel;
	
	import base.PPoint;
	
	import behavior.base.WaitBehavior;
	import behavior.core.BehaviorEvent;
	import behavior.core.LineBehavior;
	import behavior.core.ParallelBehavior;
	
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import util.DisUtil;
	import util.PosUtil;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class GridPanel extends ScrollContainer
	{
		private var m_GridModel:GridModel;
		public var m_MoveLayer:Sprite;
		
		public function GridPanel()
		{
			super();
			addEventListener( FeathersEventType.INITIALIZE, initializeHandler );
		}
		
		private function initializeHandler( event:Event ):void
		{
			removeEventListener( FeathersEventType.INITIALIZE, initializeHandler );
			
			m_GridModel = GridModel.getInstance();
			
			initBgGrid();
			
			initMover();
			
			addEvent();
		}
		
		private function initBgGrid():void
		{
			var bigBg:Quad = new Quad(FightConst.BATTLE_SIZE,FightConst.BATTLE_SIZE);
			bigBg.color = 0xB4EEB4;
			addChild(bigBg);
			
			for(var i:int = 0;i<FightConst.X_NUM;i++)
			{
				for(var j:int = 0;j<FightConst.X_NUM;j++)
				{
					var bgCell:Quad = new Quad(FightConst.CELL_SIZE,FightConst.CELL_SIZE);
					bgCell.color = 0xF4F4F4;
					bgCell.x = FightConst.CELL_GAP + j * (FightConst.CELL_SIZE + FightConst.CELL_GAP * 2);
					bgCell.y = FightConst.CELL_GAP + i * (FightConst.CELL_SIZE + FightConst.CELL_GAP * 2);
					addChild(bgCell);
				}
			}
			
			if(m_MoveLayer == null)
			{
				m_MoveLayer = new Sprite;
				addChild(m_MoveLayer);
			}
		}
		
		private function addEvent():void
		{
			addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private var m_Mover:Image;
		private function initMover():void
		{
			var shape:Shape = new Shape;
			var g:Graphics = shape.graphics;
			g.clear();
			g.beginFill(0xA52A2A,.4);
			g.drawCircle(0,0,10);
			g.endFill();
			
			var bmd:BitmapData = new BitmapData(shape.width,shape.height,true,0);
			var matrix:Matrix = new Matrix;
			matrix.translate(shape.width/2,shape.height/2);
			bmd.draw(shape,matrix);
			var texture:Texture = Texture.fromBitmapData(bmd);
			m_Mover = new Image(texture);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if(touch)
			{
				var point:Point = touch.getLocation(this);
				var cellPoint:Point = DisUtil.coordConver(point,FightConst.CELL_FULL_SIZE);
				var gridPoint:Point = DisUtil.coordConver(cellPoint,1/FightConst.CELL_FULL_SIZE);
				
				if(touch.phase == TouchPhase.BEGAN)
				{
					m_Mover.x = gridPoint.x + FightConst.CELL_FULL_SIZE_HALF - m_Mover.width/2;
					m_Mover.y = gridPoint.y + FightConst.CELL_FULL_SIZE_HALF - m_Mover.height/2;
					addChild(m_Mover);
					m_GridModel.line(cellPoint.x,cellPoint.y);
				}
				
				if(touch.phase == TouchPhase.ENDED)
				{
					removeChild(m_Mover);
					m_GridModel.clearLine();
				}
				
				if(touch.phase == TouchPhase.MOVED)
				{
					if(PosUtil.inLen(point.x,point.y,gridPoint.x + FightConst.CELL_FULL_SIZE_HALF,gridPoint.y + FightConst.CELL_FULL_SIZE_HALF,FightConst.CELL_SIZE_HALF/2))
					{
						m_Mover.x = gridPoint.x + FightConst.CELL_FULL_SIZE_HALF - m_Mover.width/2;
						m_Mover.y = gridPoint.y + FightConst.CELL_FULL_SIZE_HALF - m_Mover.height/2;
						m_GridModel.line(cellPoint.x,cellPoint.y);
					}
				}
			}
		}
		
		public function initGrid():void
		{
			m_WaitRemoves = [];
			m_MoveLayer.removeChildren();
			
			var cells:Vector.<CellInfo> = m_GridModel.getCells();
			
			var i:int = 0;
			
			for(;i<cells.length;i++)
			{
				var cellInfo:CellInfo = cells[i];
				var cellItem:CellItem = new CellItem(cellInfo);
				m_MoveLayer.addChild(cellItem);
			}
		}
		
		public function getCellItemByInfo(cellInfo:CellInfo):CellItem
		{
			var i:int = 0;
			var cellItem:CellItem;
			for(;i<m_MoveLayer.numChildren;i++)
			{
				cellItem = m_MoveLayer.getChildAt(i) as CellItem;
				if(cellItem)
				{
					var myCellInfo:CellInfo = cellItem.getInfo();
					if(( myCellInfo.m_XNum == cellInfo.m_XNum ) && ( myCellInfo.m_YNum == cellInfo.m_YNum ))
					{
						if(m_WaitRemoves.indexOf(cellItem) == -1)
						{
							return cellItem;
						}
					}
				}
			}
			return null;
		}
		
		private var m_WaitRemoves:Array;
		private var m_FightBehavior:LineBehavior;
		public function changeGrid():void
		{
			handleAnimationRunning(true);
			
			if(m_FightBehavior)
			{
				m_FightBehavior.onDispose();
				m_FightBehavior = null
			}
			m_FightBehavior = new LineBehavior;
			
			var lineCells:Vector.<CellInfo> = AnimationModel.getInstance().getLineCells();
			
			var i:int = 0;
			for(;i<lineCells.length;i++)
			{
				var cellInfo:CellInfo = lineCells[i];
				var cellItem:CellItem = getCellItemByInfo(cellInfo);
				if(cellItem)
				{
					var point:Point;
					if(i < (lineCells.length - 1))
					{
						var nextItem:CellItem = getCellItemByInfo(lineCells[i + 1]);
						point = new Point(nextItem.x,nextItem.y);
					}else{
						point = new Point(cellItem.x,cellItem.y);
					}
					m_WaitRemoves.push(cellItem);
					var cellReomveBH:CellRemoveBehavior = new CellRemoveBehavior(cellItem,point,FightConst.BEHAVIOR_SPEED);
					m_FightBehavior.addBehavior(cellReomveBH);
				}
			}
			
			var moves:Array = AnimationModel.getInstance().getMoves();
			for(i = 0;i<moves.length;i++)
			{
				var pps:Array = moves[i];
				moveGroup(pps);
			}
			
			var waitAMinute:WaitBehavior = new WaitBehavior(50);
			m_FightBehavior.addBehavior(waitAMinute);
			m_FightBehavior.onExecute();
			m_FightBehavior.addEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
		}
		
		private function moveGroup(pps:Array):void
		{
			if(pps.length == 0)
			{
				return;
			}
			
			var parallel:ParallelBehavior = new ParallelBehavior;
			
			var cellItem:CellItem;
			var point:Point;
			var i:int = 0;
			for(i = 0;i<pps.length;i++)
			{
				var pp:PPoint = pps[i];
				
				var tempCellInfo:CellInfo = new CellInfo;
				tempCellInfo.m_XNum = pp.m_PreX;
				tempCellInfo.m_YNum = pp.m_PreY;
				
				cellItem = getCellItemByInfo(tempCellInfo);
				if(cellItem)
				{
					cellItem.changeInfoPos(new Point(pp.m_ToX,pp.m_ToY));
					
					point = new Point(FightConst.CELL_FULL_SIZE_HALF + pp.m_ToX * FightConst.CELL_FULL_SIZE,
						FightConst.CELL_FULL_SIZE_HALF + pp.m_ToY * FightConst.CELL_FULL_SIZE);
					var moveBehavior:MoveBehavior = new MoveBehavior(cellItem,point,FightConst.BEHAVIOR_SPEED);
					
					parallel.addBehavior(moveBehavior);
				}else{
					var addCellInfo:CellInfo = GridModel.getInstance().getCell(pp.m_ToX,pp.m_ToY);
					if(addCellInfo)
					{
						var addLine:LineBehavior = new LineBehavior;
						
						var addCellInfoTemp:CellInfo = addCellInfo.copy();
						addCellInfoTemp.m_XNum = pp.m_PreX;
						addCellInfoTemp.m_YNum = -1;
						
						var addCellItem:CellItem = new CellItem(addCellInfoTemp);
						
						var addBehavior:CellAddBehavior = new CellAddBehavior(addCellItem,m_MoveLayer);
						
						addCellItem.changeInfoPos(new Point(pp.m_PreX,0));
						
						point = new Point(addCellItem.x,addCellItem.y + FightConst.CELL_FULL_SIZE);
						moveBehavior = new MoveBehavior(addCellItem,point,FightConst.BEHAVIOR_SPEED);
						
						addLine.addBehavior(addBehavior);
						addLine.addBehavior(moveBehavior);
						parallel.addBehavior(addLine);
					}
				}
			}
			m_FightBehavior.addBehavior(parallel);
		}
		
		private function onBehaviorEnd(e:BehaviorEvent):void
		{
			AnimationModel.getInstance().clear();
			if(m_FightBehavior)
			{
				m_FightBehavior.removeEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
				m_FightBehavior.onDispose();
				m_FightBehavior = null;
			}
			initGrid();
			handleAnimationRunning(false);
		}
		
		private function handleAnimationRunning(bool:Boolean):void
		{
			AnimationModel.RUNING = bool;
			if(AnimationModel.RUNING)
			{
				removeEventListener(TouchEvent.TOUCH,onTouch);
			}else{
				addEventListener(TouchEvent.TOUCH,onTouch);
			}
		}
	}
}