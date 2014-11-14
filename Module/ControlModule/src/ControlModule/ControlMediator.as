package ControlModule
{
	import ControlModule.mediator.ModulesMediator;
	
	import gema.Module.core.ModuleMediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ControlMediator extends ModuleMediator
	{
		public function ControlMediator()
		{
			super();
		}
		
		private function get view():ControlView
		{
			return getViewComponent() as ControlView;
		}
		
		override protected function initMediator():void
		{
			registerComponentMediator(view,ModulesMediator);
		}
		
		override protected function initView():void
		{
			
		}
		
		override protected function initEvent():void
		{
		}
	}
}