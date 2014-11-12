package gema.Module.base
{

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class ModuleEvent extends FlashEvent
	{
		public static const OPEN_MODULE:String = "open_module";
		
		public function ModuleEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public function getModuleName():String
		{
			return String(getData());
		}
	}
}