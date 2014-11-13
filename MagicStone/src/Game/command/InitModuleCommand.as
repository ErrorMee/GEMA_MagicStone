package Game.command
{
	import Game.MainContextEvent;
	
	import gema.Module.base.ModuleContextEvent;
	import gema.Module.base.ModuleEvent;
	import gema.Module.core.ModuleCommand;
	import gema.Module.core.ModuleManager;
	import gema.Module.layer.LayerManager;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitModuleCommand extends ModuleCommand
	{
		public function InitModuleCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			injector.mapSingleton(ModuleManager);
			injector.mapSingleton(ModuleEvent);
			
			var layerManager:LayerManager = new LayerManager;
			layerManager.setup(contextView);
			
			dispatch(new MainContextEvent(ModuleContextEvent.INIT_MODEL));
			
		}
	}
}