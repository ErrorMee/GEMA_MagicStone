package Game
{
	import org.robotlegs.mvcs.StarlingContext;
	
	import starling.display.DisplayObjectContainer;
	import FightModule.FightMediator;
	import FightModule.FightModule;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class MainContext extends StarlingContext
	{
		public function MainContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			trace("MyStarlingGameContext startup");
			mediatorMap.mapView(MainRoot, MainMediator);
			mediatorMap.mapView(StartModule,StartMediator);
			mediatorMap.mapView(FightModule,FightMediator);
			super.startup();
		}
	}
}