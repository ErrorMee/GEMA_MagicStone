package gema.behavior.base
{
	import gema.behavior.core.Behavior;
	
	import starling.core.Starling;
	
	/******************************************************
	 * 时间等待行为
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class WaitBehavior extends Behavior
	{
		private var m_Times:int;
		
		public function WaitBehavior(millisecond:int)
		{
			super();
			m_Times = millisecond/1000.0;
		}
		
		override public function onExecute():void
		{
			Starling.juggler.delayCall(onTimeEnd,m_Times);
		}
		
		private function onTimeEnd():void
		{
			onEnd();
		}
		
		override public function onDispose():void
		{
		}
	}
}