package FightModule.panel
{
	import flash.geom.Point;
	
	import FightModule.FightContext;
	import FightModule.behaviors.CellAddBehavior;
	import FightModule.behaviors.CellRemoveBehavior;
	import FightModule.behaviors.MoveBehavior;
	import FightModule.element.CellItem;
	import FightModule.model.AnimationModel;
	import FightModule.model.CellInfo;
	import FightModule.model.FightConst;
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;
	
	import gema.Module.base.FlashEvent;
	import gema.Module.core.ModuleMediator;
	import gema.behavior.base.WaitBehavior;
	import gema.behavior.core.BehaviorEvent;
	import gema.behavior.core.LineBehavior;
	import gema.behavior.core.ParallelBehavior;
	import gema.configs.CellConfig;
	import gema.configs.CellConfigInfo;
	import gema.structure.PPoint;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridPlayMediator extends ModuleMediator
	{
		[Inject]
		public var i_AnimationModel:AnimationModel;
		[Inject]
		public var i_CellConfig:CellConfig;
		[Inject]
		public var i_GridModel:GridModel;
		
		public function GridPlayMediator()
		{
			super();
		}
		
		private function get view():GridPanel
		{
			return getViewComponent() as GridPanel;
		}
		
		override protected function initEvent():void
		{
			i_GridModel.addEventListener(GridEvent.GRID_CHANGE,onGridChange);
		}
		
		private function onGridChange(e:GridEvent):void
		{
			changeGrid();
		}
		
		private var m_WaitRemoves:Array = [];
		private var m_FightBehavior:LineBehavior;
		
		private function changeGrid():void
		{
			dispatch(new FlashEvent(FightContext.EVENT_START_PLAY));
			
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
			var renderArr:Array = i_CellConfig.getGroupCellss();
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
						
						var cellConfigInfos:Array = renderArr[addCellInfoTemp.m_Type];
						var config:CellConfigInfo = cellConfigInfos[0];
						var addConfig:CellConfigInfo;
						if(cellConfigInfos.length > 1)
						{
							addConfig = cellConfigInfos[1];
						}
						addCellInfoTemp.setConfig(config,addConfig);
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
		
		private function getCellItemByInfo(cellInfo:CellInfo):CellItem
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
		
		private function onBehaviorEnd(e:BehaviorEvent):void
		{
			i_AnimationModel.clear();
			if(m_FightBehavior)
			{
				m_FightBehavior.removeEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
				m_FightBehavior.onDispose();
				m_FightBehavior = null;
			}
			dispatch(new FlashEvent(FightContext.EVENT_END_PLAY));
			m_WaitRemoves = [];
		}
	}
}