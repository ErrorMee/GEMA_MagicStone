package Game.context
{
	import Game.MainRoot;
	import Game.command.InitConfigCommand;
	import Game.command.InitModelCommand;
	import Game.command.StartGameCommand;
	import Game.view.MainMediator;
	
	import gema.Module.base.ModuleContextEvent;
	import gema.Module.base.ModuleEventDispatcher;
	
	import org.robotlegs.mvcs.StarlingContext;
	
	import starling.display.DisplayObjectContainer;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class MainContext extends StarlingContext
	{
		public function MainContext(contextView:DisplayObjectContainer=null)
		{
			super(contextView, false);
		}
		
		override public function startup():void
		{
			super.startup();
			
			/**
			 * 全局模块事件中心
			 */
			var moduleDispatcher:ModuleEventDispatcher = new ModuleEventDispatcher(this);
			injector.mapValue(ModuleEventDispatcher, moduleDispatcher);
			
			mediatorMap.mapView(MainRoot, MainMediator);
			
			mapCommand();
			
			dispatchEvent(new MainContextEvent(ModuleContextEvent.INIT_CONFIG));
		}
		
		private function mapCommand():void
		{
			commandMap.mapEvent(ModuleContextEvent.INIT_CONFIG, InitConfigCommand, MainContextEvent, true);
			commandMap.mapEvent(ModuleContextEvent.INIT_MODEL, InitModelCommand, MainContextEvent, true);
			commandMap.mapEvent(MainContextEvent.START_GAME, StartGameCommand, MainContextEvent, true);
		}
	}
}