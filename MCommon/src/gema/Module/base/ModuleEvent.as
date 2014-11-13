package gema.Module.base
{
	import gema.structure.EnumVo;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class ModuleEvent extends FlashEvent
	{
		/**
		 * log事件
		 */
		public static const ME_LOG:EnumVo = new EnumVo().setName("me_log");
		/**
		 * 模块进入
		 */
		public static const ME_ENTER:EnumVo = new EnumVo().setName("me_enter");
		/**
		 * 模块更新
		 */
		public static const ME_UPDATE:EnumVo = new EnumVo().setName("me_update");
		/**
		 * 模块关闭
		 */
		public static const ME_CLOSE:EnumVo = new EnumVo().setName("me_close");
		/**
		 * 模块销毁
		 */
		public static const ME_DISPOSE:EnumVo = new EnumVo().setName("me_dispose");
		
		private static var g_ModuleEvent:ModuleEvent;
		private static var g_ModuleEventInfo:ModuleEventInfo;
		
		public function ModuleEvent(type:String = "o,no", data:ModuleEventInfo=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public function create(type:String,param:Object = null,from:String = null):ModuleEvent
		{
			return new ModuleEvent(type,new ModuleEventInfo(from,param));
		}
		
		public function createControl(type:String,controlModule:String,from:String = null):ModuleEvent
		{
			return new ModuleEvent(type,new ModuleEventInfo(from,new ModuleInfo(controlModule)));
		}
		
		public function creatLog(param:String = null,from:String = null):ModuleEvent
		{
			return new ModuleEvent(ME_LOG.m_Name,new ModuleEventInfo(from,param));
		}
		
		private function updateInfo(from:String,param:Object = null):ModuleEventInfo
		{
			if(g_ModuleEventInfo == null)
			{
				g_ModuleEventInfo = new ModuleEventInfo;
			}
			g_ModuleEventInfo.m_ModuleFrom = from;
			g_ModuleEventInfo.m_Data = param;
			return g_ModuleEventInfo;
		}
		
		/**
		 * 目的在于优化内存 
		 * 优点：减少了ModuleEvent实例化次数 （暂未证实）
		 * 缺点：只侦听器只支持Event类型 不支持自定义类型（不支持数据携带）
		 */
		public function update(type:String):ModuleEvent
		{
			if(g_ModuleEvent == null)
			{
				g_ModuleEvent = new ModuleEvent(type);
			}else{
				if(g_ModuleEvent.type != type)
				{
					g_ModuleEvent = new ModuleEvent(type);
				}
			}
			return g_ModuleEvent;
		}
		
		public function getInfo():ModuleEventInfo
		{
			return getData() as ModuleEventInfo;
		}
		
		public function getModuleInfo():ModuleInfo
		{
			var moduleEventInfo:ModuleEventInfo = getInfo();
			if(moduleEventInfo)
			{
				return (moduleEventInfo.m_Data as ModuleInfo);
			}
			return null;
		}
	}
}