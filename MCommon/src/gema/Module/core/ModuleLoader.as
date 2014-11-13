package gema.Module.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleLoader extends Loader
	{
		public function ModuleLoader()
		{
			super();
		}
		
		public function handleContentLoadComplete(fun:Function):void
		{
			m_CompleteFun = fun;
			contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		
		private var m_CompleteFun:Function = null;
		private function onComplete(e:Event):void
		{
			contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
			if(m_CompleteFun)
			{
				m_CompleteFun(m_ModuleName);
				m_CompleteFun = null;
			}
		}
		
		private var m_ModuleName:String;
		public function loadModule(moduleData:ByteArray,moduleName:String):void
		{
			m_ModuleName = moduleName;
			var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			loaderContext.allowCodeImport = true; 
			loadBytes(moduleData,loaderContext);
		}
	}
}