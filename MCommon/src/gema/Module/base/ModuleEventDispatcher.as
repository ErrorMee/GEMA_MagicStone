package gema.Module.base
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleEventDispatcher extends EventDispatcher
	{
		public function ModuleEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}