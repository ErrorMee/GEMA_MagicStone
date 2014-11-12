package FightModule
{
	import flash.utils.ByteArray;
	
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	import gema.util.AssetsUtil;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class FightMediator extends StarlingMediator
	{
		private var m_GridModel:GridModel;
		
		public function FightMediator()
		{
			super();
		}
		
		private function get view():FightModule
		{
			return getViewComponent() as FightModule;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			m_GridModel = GridModel.getInstance();
			
			var gridDat:ByteArray = AssetsUtil.ASSET.getByteArray("10000");
			m_GridModel.loadData(gridDat);
			
			view.headerProperties.title = "" + m_GridModel.m_ID;
			
			view.m_GridPanel.initGrid();
			
			addEvent();
		}
		
		private function addEvent():void
		{
			m_GridModel.addEventListener(GridEvent.GRID_CHANGE,onGridChange);
		}
		
		private function onGridChange(e:GridEvent):void
		{
			view.m_GridPanel.changeGrid();
		}
	}
}