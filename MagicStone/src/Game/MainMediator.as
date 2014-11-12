package Game
{
	import gema.Module.ModuleEvent;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	import starling.events.Event;
	import FightModule.FightModule;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class MainMediator extends StarlingMediator
	{
		public function MainMediator()
		{
			super();
		}
		
		private function get view():MainRoot
		{
			return getViewComponent() as MainRoot;
		}
		
		override public function setViewComponent(viewComponent:Object):void
		{
			super.setViewComponent(viewComponent);
			trace("MainMediator setViewComponent");
		}
		
		override public function preRegister():void
		{
			super.preRegister();
			trace("MainMediator preRegister");
		}
		
		private function onOpenModule(e:ModuleEvent):void
		{
			trace("onOpenModule " + e.getModuleName());
			view.showScreen(e.getModuleName());
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			trace("MainMediator onRegister");
			addEvent();
		}
		
		private function addEvent():void
		{
			view.addEventListener(Event.COMPLETE,onMainRootComplete);
			addContextListener(ModuleEvent.OPEN_MODULE, onOpenModule);
		}
		
		private function onMainRootComplete(e:Event):void
		{
			view.removeEventListener(Event.COMPLETE,onMainRootComplete);
			
			view.addScreen("StartModule",StartModule);
			view.addScreen("FightModule",FightModule);
			
			view.showScreen("StartModule");
		}
		
		override public function preRemove():void
		{
			super.preRemove();
			trace("MainMediator preRemove");
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			trace("MainMediator onRemove");
		}
	}
}