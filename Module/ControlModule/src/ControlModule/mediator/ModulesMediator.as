package ControlModule.mediator
{
	import ControlModule.ControlView;
	
	import gema.Module.base.ModuleEvent;
	import gema.Module.base.ModuleInfo;
	import gema.Module.core.ModuleManager;
	import gema.Module.core.ModuleMediator;
	import gema.Module.interfaces.IModule;
	import gema.Module.layer.LayerMgr;
	import gema.configs.ModuleConfig;
	import gema.util.Constants;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModulesMediator extends ModuleMediator
	{
		[Inject]
		public var i_ModuleManager:ModuleManager;
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		
		public function ModulesMediator()
		{
			super();
		}
		
		private function get view():ControlView
		{
			return getViewComponent() as ControlView;
		}
		
		override protected function initEvent():void
		{
			addModuleListener(ModuleEvent.ME_ENTER.m_Name,onModuleEnter);
			addModuleListener(ModuleEvent.ME_CLOSE.m_Name,onModuleClose);
			addModuleListener(ModuleEvent.ME_DISPOSE.m_Name,onModuleDispose);
		}
		
		override protected function initRequest():void
		{
			LayerMgr.CONTROL_SCREENNAVIGATOR_LAYER = view.m_MainNavigator.m_Navigator;
			openModule(i_ModuleConfig.getModuleDevName(10001));
		}
		
		private function onModuleEnter(e:ModuleEvent):void
		{
			var moduleInfo:ModuleInfo = e.getModuleInfo();
			if(moduleInfo == null) return ;
			i_ModuleManager.openModule(moduleInfo,onOpenComplete);
		}
		
		private function onOpenComplete(moduleInstance:IModule):void
		{
			log("open " + moduleInstance.getName(),i_ModuleConfig.getModuleDevName(10000));
			Constants.MAIN_INJECTOR.injectInto(moduleInstance);
			moduleInstance.startUp(Constants.MAIN_INJECTOR);
		}
		
		private function onModuleClose(e:ModuleEvent):void
		{
			var moduleInfo:ModuleInfo = e.getModuleInfo();
			if(moduleInfo == null) return ;
			i_ModuleManager.closeModule(moduleInfo,onCloseComplete);
		}
		
		private function onCloseComplete(moduleInstance:IModule):void
		{
			log("close " + moduleInstance.getName(),i_ModuleConfig.getModuleDevName(10000));
		}
		
		private function onModuleDispose(e:ModuleEvent):void
		{
			var moduleInfo:ModuleInfo = e.getModuleInfo();
			if(moduleInfo == null) return ;
			i_ModuleManager.destroyModule(moduleInfo);
			log("dispose " + moduleInfo.m_Name,i_ModuleConfig.getModuleDevName(10000));
		}
	}
}