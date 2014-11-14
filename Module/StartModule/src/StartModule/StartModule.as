package StartModule
{
	import flash.system.ApplicationDomain;
	
	import gema.Module.core.Module;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class StartModule extends Module
	{
		public function StartModule()
		{
			super();
		}
		
		override protected function onStartUp():void
		{
			initModule(StartView,StartContext,ApplicationDomain.currentDomain);
		}
	}
}