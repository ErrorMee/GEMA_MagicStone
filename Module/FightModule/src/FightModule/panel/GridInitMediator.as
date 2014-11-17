package FightModule.panel
{
	import flash.utils.ByteArray;
	
	import FightModule.FightContext;
	import FightModule.element.CellItem;
	import FightModule.model.CellInfo;
	import FightModule.model.GridModel;
	import FightModule.model.func.GridModelLoadDataFunc;
	
	import gema.Module.base.FlashEvent;
	import gema.Module.core.ModuleMediator;
	import gema.configs.CellConfig;
	import gema.configs.CellConfigInfo;
	import gema.util.AssetsUtil;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridInitMediator extends ModuleMediator
	{
		[Inject]
		public var i_GridModel:GridModel;
		[Inject]
		public var i_CellConfig:CellConfig;
		
		public function GridInitMediator()
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
			GridModelLoadDataFunc.loadData(i_GridModel,gridDat);
			initGrid(i_GridModel.m_Cells);
		}
		
		override protected function initEvent():void
		{
			addContextListener(FightContext.EVENT_END_PLAY,onPalyEnd);
		}
		
		private function onPalyEnd(e:FlashEvent):void
		{
			initGrid(i_GridModel.m_Cells);
		}
		
		private function initGrid(cells:Vector.<CellInfo>):void
		{
			view.m_MoveLayer.removeChildren();
			
			var renderArr:Array = i_CellConfig.getGroupCellss();
			
			var i:int = 0;
			for(;i<cells.length;i++)
			{
				var cellInfo:CellInfo = cells[i];
				var cellConfigInfos:Array = renderArr[cellInfo.m_Type];
				var config:CellConfigInfo = cellConfigInfos[0];
				var addConfig:CellConfigInfo;
				if(cellConfigInfos.length > 1)
				{
					addConfig = cellConfigInfos[1];
				}
				cellInfo.setConfig(config,addConfig);
				var cellItem:CellItem = new CellItem(cellInfo);
				view.m_MoveLayer.addChild(cellItem);
			}
		}
	}
}