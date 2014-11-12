package Game.command
{
	import Game.MainRoot;
	
	import gema.Module.base.ModuleEvent;
	import gema.Module.core.ModuleCommand;
	import gema.configs.ModuleConfig;
	import gema.configs.ModuleConfigInfo;
	import gema.util.Constants;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class StartGameCommand extends ModuleCommand
	{
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		
		public function StartGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var maiRoot:MainRoot = contextView as MainRoot;
			if(maiRoot)
			{
				var modules:Array = i_ModuleConfig.getConfigInfos(true);
				var modulesLen:int = modules.length;
				var i:int = 0;
				for(;i<modulesLen;i++)
				{
					var moduleConfigInfo:ModuleConfigInfo = modules[i] as ModuleConfigInfo;
					
					var moduleCls:Class = Constants.getClassByName(moduleConfigInfo.getClassName());
					
					maiRoot.addScreen(moduleConfigInfo.dev_name,moduleCls);
					
					var medtiatorCls:Class = Constants.getClassByName(moduleConfigInfo.dev_name + "Module." + moduleConfigInfo.dev_name + "Mediator");
					
					mediatorMap.mapView(moduleCls,medtiatorCls);
				}
				dispatchToContext(new ModuleEvent(ModuleEvent.OPEN_MODULE,"Start"));
			}
		}
	}
}