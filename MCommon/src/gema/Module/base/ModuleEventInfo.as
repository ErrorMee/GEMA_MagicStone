package gema.Module.base
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleEventInfo
	{
		/**
		 * 事件来自哪个模块
		 */
		public var m_ModuleFrom:String;
		
		public var m_Data:Object;
		
		public function ModuleEventInfo(from:String = null,data:Object = null)
		{
			m_ModuleFrom = from;
			m_Data = data;
		}
	}
}