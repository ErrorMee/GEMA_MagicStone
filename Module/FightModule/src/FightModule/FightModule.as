package FightModule
{
	
	import flash.system.ApplicationDomain;
	
	import FightModule.panel.GridPanel;
	import FightModule.panel.LinePanel;
	
	import gema.Module.core.Module;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class FightModule extends Module
	{
		public var m_GridPanel:GridPanel;
		
		public var m_LinePanel:LinePanel;
		
		public function FightModule()
		{
			super();
		}
		
		override protected function onStartUp():void
		{
			initModule(FightView,FightContext,ApplicationDomain.currentDomain);
		}
	}
}