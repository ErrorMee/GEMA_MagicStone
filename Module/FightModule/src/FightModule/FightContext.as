package FightModule
{
	import flash.system.ApplicationDomain;
	
	import FightModule.model.AnimationModel;
	import FightModule.model.GridModel;
	
	import gema.Module.core.ModuleContext;
	
	import org.robotlegs.core.IInjector;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class FightContext extends ModuleContext
	{
		public static const EVENT_START_PLAY:String = "event_start_play";
		public static const EVENT_END_PLAY:String = "event_end_play";
		
		public function FightContext(contextView:DisplayObjectContainer=null, parentInjector:IInjector=null, domain:ApplicationDomain=null)
		{
			super(contextView, parentInjector, domain);
		}
		
		override protected function registMSCV():void
		{
			injector.mapSingleton(GridModel);
			injector.mapSingleton(AnimationModel);
			
			registView(FightView,FightMediator);
		}
	}
}