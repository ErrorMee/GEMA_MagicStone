package Game.context
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
		public static const START_GAME:String = "start_game";
		
		public function MainContextEvent(type:String, body:*=null)
		{
			super(type, body);
		}
	}
}