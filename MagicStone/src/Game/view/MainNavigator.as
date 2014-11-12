package Game.view
{
	import feathers.controls.Drawers;
	import feathers.controls.ScreenNavigator;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.display.DisplayObject;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class MainNavigator extends Drawers
	{
		public function MainNavigator(content:DisplayObject=null)
		{
			super(content);
		}
		
		public var m_Navigator:ScreenNavigator;
		private var m_TransitionManager:ScreenSlidingStackTransitionManager;
		
		override protected function initialize():void
		{
			super.initialize();
			m_Navigator = new ScreenNavigator;
			content = m_Navigator;
			
			m_TransitionManager = new ScreenSlidingStackTransitionManager(this.m_Navigator);
			m_TransitionManager.duration = 0.4;
		}
	}
}