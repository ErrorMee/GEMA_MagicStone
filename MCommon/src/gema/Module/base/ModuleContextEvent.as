package gema.Module.base
{
	import org.robotlegs.base.ContextEvent;
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class ModuleContextEvent extends ContextEvent
	{
		public static const INIT_CONFIG:String = "init_config";
		
		public static const INIT_MODEL:String = "init_model";
		
		public function ModuleContextEvent(type:String, body:*=null)
		{
			super(type, body);
		}
	}
}