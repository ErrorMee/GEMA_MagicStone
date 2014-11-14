package gema.Module.core
{
	import flash.events.Event;
	
	import gema.Module.base.ModuleEvent;
	import gema.Module.base.ModuleEventDispatcher;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleMediator extends StarlingMediator
	{
		[Inject]
		public var i_ModuleDispatcher:ModuleEventDispatcher;
		[Inject]
		public var i_ModuleEvent:ModuleEvent;
		[Inject]
		public var i_Injector:IInjector;
		
		public function ModuleMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			initMediator();
			initView();
			initEvent();
			initRequest();
		}
		
		protected function initMediator():void 
		{
		}
		
		protected function initView():void
		{
		}
		
		protected function initEvent():void
		{
		}
		
		protected function removeEvent():void
		{
		}
		
		protected function initRequest():void
		{
		}
		
		protected function addModuleListener(type:String, listener:Function, eventClass:Class = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			eventMap.mapListener(i_ModuleDispatcher, type, listener, eventClass, useCapture, priority, useWeakReference);
		}
		
		protected function removeModuleListener(type:String, listener:Function, eventClass:Class = null, useCapture:Boolean = false):void
		{
			eventMap.unmapListener(i_ModuleDispatcher, type, listener, eventClass, useCapture);
		}
		
		protected function dispatchToModules(event:Event):Boolean
		{
			if(i_ModuleDispatcher.hasEventListener(event.type))
			{
				return i_ModuleDispatcher.dispatchEvent(event);				
			}				
			return false;
		}
		
		protected function registerComponentMediator(component:Object,mediatorCls:Class):void
		{
			if(null == mediatorCls || component == null) 
			{
				return;
			}
			var componentMediator:ModuleMediator = new mediatorCls();
			i_Injector.injectInto(componentMediator);
			mediatorMap.registerMediator(component,componentMediator);
		}
		
		/**
		 * 发送日志
		 */
		protected function log(param:String,from:String = null):void
		{
			dispatchToModules(i_ModuleEvent.creatLog(param,from));
		}
		
		protected function openModule(name:String,data:Object = null,refresh:Boolean = false):void 
		{
			if(name == null)
			{
				trace("openModule name == null");
				return;
			}
			if(refresh)
			{
				dispatchToModules(i_ModuleEvent.createControl(ModuleEvent.ME_UPDATE.m_Name,name));
			}
			else
			{
				dispatchToModules(i_ModuleEvent.createControl(ModuleEvent.ME_ENTER.m_Name,name));
			}
		}
		
		/**
		 * dispose：尽量别去销毁模块 目前没有实现内存回收（欢迎解答）
		 */
		protected function closeModule(name:String,dispose:Boolean = false):void
		{
			if(name == null)
			{
				trace("closeModule name == null");
				return;
			}
			if(dispose)
			{
				dispatchToModules(i_ModuleEvent.createControl(ModuleEvent.ME_DISPOSE.m_Name,name));
			}else{
				dispatchToModules(i_ModuleEvent.createControl(ModuleEvent.ME_CLOSE.m_Name,name));
			}
		}
		
		override public function onRemove():void
		{
			removeEvent();
		}
	}
}