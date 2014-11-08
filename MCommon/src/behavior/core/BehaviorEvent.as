package behavior.core
{
	import starling.events.Event;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class BehaviorEvent extends Event
	{
		public static const BEHAVIOR_END:String = "behavior_end";
		
		public static const BEHAVIOR_CONTINUE:String = "action_continue";
		
		public function BehaviorEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}