package StartModule
{
	import flash.system.ApplicationDomain;
	
	import gema.Module.core.ModuleContext;
	
	import org.robotlegs.core.IInjector;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class StartContext extends ModuleContext
	{
		public function StartContext(contextView:DisplayObjectContainer=null, parentInjector:IInjector=null, domain:ApplicationDomain=null)
		{
			super(contextView, parentInjector, domain);
		}
		
		override protected function registMSCV():void
		{
			registView(StartView,StartMediator);
		}
	}
}