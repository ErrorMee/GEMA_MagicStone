package FightModule
{
	import flash.utils.ByteArray;
	
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;
	
	import gema.Module.core.ModuleMediator;
	import gema.util.AssetsUtil;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class FightMediator extends ModuleMediator
	{
		private var m_GridModel:GridModel;
		
		public function FightMediator()
		{
			super();
		}
		
		private function get view():FightView
		{
			return getViewComponent() as FightView;
		}
		
		override protected function initView():void
		{
			m_GridModel = GridModel.getInstance();
			
			var gridDat:ByteArray = AssetsUtil.ASSET.getByteArray("10000");
			m_GridModel.loadData(gridDat);
			
			view.headerProperties.title = "" + m_GridModel.m_ID;
			
			view.m_GridPanel.initGrid();
		}
		
		
		override protected function initEvent():void
		{
			m_GridModel.addEventListener(GridEvent.GRID_CHANGE,onGridChange);
		}
		
		private function onGridChange(e:GridEvent):void
		{
			view.m_GridPanel.changeGrid();
		}
	}
}