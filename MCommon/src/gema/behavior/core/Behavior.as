package gema.behavior.core
{
	import starling.events.EventDispatcher;
	
	/******************************************************
	 * 行为基类
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class Behavior extends EventDispatcher
	{
		public function Behavior()
		{
			super();
		}
		
		public function onExecute():void
		{
		}
		
		public function onClear():void
		{
		}
		
		public function onDispose():void
		{
		}
		
		protected function onEnd():void
		{
			dispatchEvent(new BehaviorEvent(BehaviorEvent.BEHAVIOR_END));
		}
	}
}