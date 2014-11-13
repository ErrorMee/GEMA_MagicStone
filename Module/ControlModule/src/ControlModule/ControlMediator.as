package ControlModule
{
	import gema.Module.core.ModuleMediator;
	import gema.configs.ModuleConfig;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ControlMediator extends ModuleMediator
	{
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		
		public function ControlMediator()
		{
			super();
		}
		
		private function get view():ControlView
		{
			return getViewComponent() as ControlView;
		}
		
		override protected function initView():void
		{
			var moduels:Array = i_ModuleConfig.getConfigInfos(true);
			
//			view.addScreen(
		}
	}
}