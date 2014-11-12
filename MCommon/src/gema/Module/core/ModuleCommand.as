package gema.Module.core
{
	import flash.events.Event;
	
	import gema.Module.base.ModuleEventDispatcher;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:模块基础命令
	 */
	public class ModuleCommand extends StarlingCommand
	{
		[Inject]
		public var m_ModuleEventDispatcher:ModuleEventDispatcher;
		
		public function ModuleCommand()
		{
			super();
		}
		
		/**
		 * 发送全局框架事件
		 */
		protected function dispatchToModules(event:Event):Boolean
		{
			if(m_ModuleEventDispatcher.hasEventListener(event.type))
				return m_ModuleEventDispatcher.dispatchEvent(event);
			return true;
		}
		
		/**
		 * 发送模块内框架事件
		 */
		protected function dispatchToContext(event:Event):Boolean
		{
			if(eventDispatcher.hasEventListener(event.type))
				return eventDispatcher.dispatchEvent(event);
			return false;
		}
	}
}