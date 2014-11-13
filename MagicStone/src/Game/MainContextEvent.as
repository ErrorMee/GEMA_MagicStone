package Game
{
	import gema.Module.base.ModuleContextEvent;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class MainContextEvent extends ModuleContextEvent
	{
		public static const INIT_MODULE:String = "init_module";
		
		public static const INIT_CONTROL:String = "init_control";
		
		public function MainContextEvent(type:String, body:*=null)
		{
			super(type, body);
		}
	}
}