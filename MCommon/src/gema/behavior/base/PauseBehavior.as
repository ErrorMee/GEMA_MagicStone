package gema.behavior.base
{
	import gema.behavior.core.Behavior;
	import gema.behavior.core.BehaviorEvent;
	
	import starling.events.EventDispatcher;
	
	/******************************************************
	 * 暂停行为
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class PauseBehavior extends Behavior
	{
		private var m_EventDispatcher:EventDispatcher;
		
		public function PauseBehavior(eventDispatcher:EventDispatcher)
		{
			super();
			m_EventDispatcher = eventDispatcher;
		}
		
		override public function onExecute():void
		{
			m_EventDispatcher.addEventListener(BehaviorEvent.BEHAVIOR_CONTINUE,onContinue);
		}
		
		private function onContinue(e:BehaviorEvent):void
		{
			m_EventDispatcher.removeEventListener(BehaviorEvent.BEHAVIOR_CONTINUE,onContinue);
			onEnd();
		}
		
		override public function onDispose():void
		{
			if(m_EventDispatcher) 
			{
				m_EventDispatcher.removeEventListener(BehaviorEvent.BEHAVIOR_CONTINUE,onContinue);
				m_EventDispatcher = null;
			}
		}
	}
}