package ControlModule
{
	import flash.system.ApplicationDomain;
	
	import gema.Module.core.Module;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:control模块主要负责项目的模块管理 性能分析 运行日志等等
	 */
	public class ControlModule extends Module
	{
		public function ControlModule()
		{
			super();
		}
		
		override protected function onStartUp():void
		{
			initModule(ControlView,ControlContext,ApplicationDomain.currentDomain);
		}
	}
}