package gema.Module.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import feathers.controls.ScreenNavigatorItem;
	
	import gema.Module.base.ModuleInfo;
	import gema.Module.interfaces.IModule;
	import gema.Module.interfaces.IModuleManager;
	import gema.Module.layer.LayerMgr;
	import gema.structure.HashMap;
	import gema.util.AssetsUtil;
	import gema.util.Constants;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleManager implements IModuleManager
	{
		private static const MODULE_NAME_SUFFIX:String = "Module";
		private static const MODULE_PATH:String = "module/";
		private static const MODULE_FILE_SUFFIX:String = ".swf";
		
		private var m_ModuleList:HashMap = new HashMap;
		private var m_ModuleReadyList:HashMap = new HashMap;
		
		public function ModuleManager()
		{
		}
		
		public function getModule(moduleType:String):IModule
		{
			return m_ModuleList.get(moduleType) as IModule;
		}
		
		public function openModule(info:ModuleInfo, callBack:Function=null):void
		{
			if(null == info) return;
			var module:IModule = getModule(info.m_Name);
			
			if(module)
			{
				
			}else{
				
				var moduleData:ByteArray = AssetsUtil.ASSET.getByteArray(info.m_Name + "Module");
				
				var moduleLoader:ModuleLoader = new ModuleLoader();
				moduleLoader.handleContentLoadComplete(moduleCompleteHandler);
				moduleLoader.loadModule(moduleData,info.m_Name);
				
				m_ModuleReadyList.put(info.m_Name,{info:info,callBack:callBack});
			}
		}
		
		private function moduleCompleteHandler(moduleName:String):void
		{
			var moduleReadyInfo:Object = m_ModuleReadyList.get(moduleName,true);
			var module:IModule = getModule(moduleName);
			if(module) 
			{
				throw(new Error("重复模块加载：" + moduleName));
				return;
			}
			var moduleFullName:String = moduleName + MODULE_NAME_SUFFIX;
			var moduleClassName:String = moduleFullName + "." + moduleFullName;
			var moduelViewClassName:String = moduleFullName + "." + moduleName + "View";
			
			var info:ModuleInfo = moduleReadyInfo.info;
			
			linkModule(info,moduleClassName,moduelViewClassName);
			
			module = getModule(moduleName);
			if(module)
			{
				var callBack:Function = moduleReadyInfo.callBack;
				if(callBack != null) 
				{
					callBack(module);
					callBack = null;
				}
			}
		}
		
		private function linkModule(info:ModuleInfo,className:String,viewClsName:String):void
		{
			if(null == info) return;
			if(getModule(info.m_Name)) return;
			var ModuleClass:Class = Constants.getClassByName(className);
			if(ModuleClass)
			{
				var moduleInstanse:IModule = new ModuleClass() as IModule;
				moduleInstanse.setName(info.m_Name);
				m_ModuleList.put(info.m_Name,moduleInstanse);
				
				if(LayerMgr.CONTROL_SCREENNAVIGATOR_LAYER)
				{
					var viewCls:Class = Constants.getClassByName(viewClsName);
					LayerMgr.CONTROL_SCREENNAVIGATOR_LAYER.addScreen(info.m_Name,new ScreenNavigatorItem(viewCls));
				}
			}
		}
		
		public function closeModule(info:ModuleInfo,callBack:Function = null):void
		{
			var moduleInstance:IModule = getModule(info.m_Name);
			if(!moduleInstance) return;
			moduleInstance.close();
			
			if(callBack != null) 
			{
				callBack(moduleInstance);
				callBack = null;
			}
		}
		
		public function destroyModule(info:ModuleInfo,callBack:Function=null):void
		{
			var moduleInstance:IModule = getModule(info.m_Name);
			if(!moduleInstance) return;
			moduleInstance.dispose();
			m_ModuleList.put(info.m_Name,null);
		}
	}
}