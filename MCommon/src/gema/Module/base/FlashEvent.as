package gema.Module.base
{
	import flash.events.Event;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class FlashEvent extends Event
	{
		private var m_Data:Object;
		
		public function FlashEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			m_Data = data;
		}
		
		public function getData():Object
		{
			return m_Data;
		}
	}
}