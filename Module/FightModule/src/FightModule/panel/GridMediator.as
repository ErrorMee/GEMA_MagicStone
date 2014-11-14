package FightModule.panel
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import FightModule.behaviors.CellAddBehavior;
	import FightModule.behaviors.CellRemoveBehavior;
	import FightModule.behaviors.MoveBehavior;
	import FightModule.element.CellItem;
	import FightModule.model.AnimationModel;
	import FightModule.model.CellInfo;
	import FightModule.model.FightConst;
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;
	
	import gema.Module.core.ModuleMediator;
	import gema.behavior.base.WaitBehavior;
	import gema.behavior.core.BehaviorEvent;
	import gema.behavior.core.LineBehavior;
	import gema.behavior.core.ParallelBehavior;
	import gema.structure.PPoint;
	import gema.util.AssetsUtil;
	import gema.util.DisUtil;
	import gema.util.PosUtil;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridMediator extends ModuleMediator
	{
		[Inject]
		public var i_GridModel:GridModel;
		[Inject]
		public var i_AnimationModel:AnimationModel;
		
		public function GridMediator()
		{
			super();
		}
		private function get view():GridPanel
		{
			return getViewComponent() as GridPanel;
		}
		
		override protected function initView():void
		{
			var gridDat:ByteArray = AssetsUtil.ASSET.getByteArray("10000");
			i_GridModel.loadData(gridDat);
			initGrid(i_GridModel.getCells());
		}
		
		override protected function initEvent():void
		{
			i_GridModel.addEventListener(GridEvent.GRID_CHANGE,onGridChange);
			view.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onGridChange(e:GridEvent):void
		{
			changeGrid();
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(view);
			if(touch)
			{
				var point:Point = touch.getLocation(view);
				var cellPoint:Point = DisUtil.coordConver(point,FightConst.CELL_FULL_SIZE);
				var gridPoint:Point = DisUtil.coordConver(cellPoint,1/FightConst.CELL_FULL_SIZE);
				
				if(touch.phase == TouchPhase.BEGAN)
				{
					view.m_Mover.x = gridPoint.x + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.width/2;
					view.m_Mover.y = gridPoint.y + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.height/2;
					view.addChild(view.m_Mover);
					i_GridModel.line(cellPoint.x,cellPoint.y);
				}
				
				if(touch.phase == TouchPhase.ENDED)
				{
					view.removeChild(view.m_Mover);
					i_GridModel.clearLine();
				}
				
				if(touch.phase == TouchPhase.MOVED)
				{
					if(PosUtil.inLen(point.x,point.y,gridPoint.x + FightConst.CELL_FULL_SIZE_HALF,gridPoint.y + FightConst.CELL_FULL_SIZE_HALF,FightConst.CELL_SIZE_HALF/2))
					{
						view.m_Mover.x = gridPoint.x + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.width/2;
						view.m_Mover.y = gridPoint.y + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.height/2;
						i_GridModel.line(cellPoint.x,cellPoint.y);
					}
				}
			}
		}
		
		public function initGrid(cells:Vector.<CellInfo>):void
		{
			m_WaitRemoves = [];
			view.m_MoveLayer.removeChildren();
			
			var i:int = 0;
			for(;i<cells.length;i++)
			{
				var cellInfo:CellInfo = cells[i];
				var cellItem:CellItem = new CellItem(cellInfo);
				view.m_MoveLayer.addChild(cellItem);
			}
		}
		
		public function getCellItemByInfo(cellInfo:CellInfo):CellItem
		{
			var i:int = 0;
			var cellItem:CellItem;
			for(;i<view.m_MoveLayer.numChildren;i++)
			{
				cellItem = view.m_MoveLayer.getChildAt(i) as CellItem;
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
			
			var lineCells:Vector.<CellInfo> = i_AnimationModel.getLineCells();
			
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
			
			var moves:Array = i_AnimationModel.getMoves();
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
					var addCellInfo:CellInfo = i_GridModel.getCell(pp.m_ToX,pp.m_ToY);
					if(addCellInfo)
					{
						var addLine:LineBehavior = new LineBehavior;
						
						var addCellInfoTemp:CellInfo = addCellInfo.copy();
						addCellInfoTemp.m_XNum = pp.m_PreX;
						addCellInfoTemp.m_YNum = -1;
						
						var addCellItem:CellItem = new CellItem(addCellInfoTemp);
						
						var addBehavior:CellAddBehavior = new CellAddBehavior(addCellItem,view.m_MoveLayer);
						
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
			i_AnimationModel.clear();
			if(m_FightBehavior)
			{
				m_FightBehavior.removeEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
				m_FightBehavior.onDispose();
				m_FightBehavior = null;
			}
			initGrid(i_GridModel.getCells());
			handleAnimationRunning(false);
		}
		
		private function handleAnimationRunning(bool:Boolean):void
		{
			AnimationModel.RUNING = bool;
			if(AnimationModel.RUNING)
			{
				view.removeEventListener(TouchEvent.TOUCH,onTouch);
			}else{
				view.addEventListener(TouchEvent.TOUCH,onTouch);
			}
		}
	}
}