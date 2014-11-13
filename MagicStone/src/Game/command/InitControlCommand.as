package Game.command
{
	import gema.Module.base.ModuleInfo;
	import gema.Module.core.ModuleCommand;
	import gema.Module.core.ModuleManager;
	import gema.Module.interfaces.IModule;
	import gema.configs.ModuleConfig;
	import gema.configs.ModuleConfigInfo;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitControlCommand extends ModuleCommand
	{
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		[Inject]
		public var i_ModuleManager:ModuleManager;
		
		public function InitControlCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var moduleInfo:ModuleInfo = new ModuleInfo();
			var moduleConfigInfo:ModuleConfigInfo = i_ModuleConfig.getConfigInfo(10000) as ModuleConfigInfo;
			if(moduleConfigInfo)
			{
				moduleInfo.m_Name = moduleConfigInfo.dev_name;
				i_ModuleManager.openModule(moduleInfo,onOpenControlComplete);
			}
		}
		
		private function onOpenControlComplete(moduleInstance:IModule):void
		{
			injector.injectInto(moduleInstance);
			moduleInstance.startUp(injector);
		}
	}
}