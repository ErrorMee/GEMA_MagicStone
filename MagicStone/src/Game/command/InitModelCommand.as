package Game.command
{
	import Game.MainContextEvent;
	
	import gema.Module.core.ModuleCommand;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitModelCommand extends ModuleCommand
	{
		public function InitModelCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			dispatch(new MainContextEvent(MainContextEvent.INIT_CONTROL));
		}
	}
}