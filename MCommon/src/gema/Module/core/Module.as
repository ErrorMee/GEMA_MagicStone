package gema.Module.core
{
	import flash.system.ApplicationDomain;
	
	import gema.Module.interfaces.IModule;
	import gema.Module.interfaces.IModuleContext;
	import gema.Module.layer.LayerMgr;
	import gema.structure.EnumVo;
	import gema.util.DisUtil;
	
	import org.robotlegs.core.IInjector;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	public class Module implements IModule
	{
		protected var m_ParentContainer:DisplayObjectContainer;
		protected var m_ModuleView:Sprite;
		protected var m_ModuleContext:IModuleContext;
		
		private var m_StartUpParam:Object;
		private var m_UpdateParam:Object;
		private var m_Name:String;
		private var m_IsClosed:Boolean = true;
		
		protected var m_ParentInjector:IInjector;
		
		public function Module()
		{
		}
		
		public function startUp(injector:IInjector=null, startUpParameter:Object=null):void
		{
			m_ParentInjector = injector;	
			
			m_IsClosed = true;
			m_StartUpParam = startUpParameter;
			
			onStartUp();
		}
		
		public function getStartUpParam():Object
		{
			return m_StartUpParam;
		}
		
		public function update(param:Object=null):void
		{
			m_IsClosed = false;
			m_UpdateParam = param;
		}
		
		public function getUpdateParam():Object
		{
			return m_UpdateParam;
		}
		
		public function close():void
		{
			m_IsClosed = true;
			
			onClose();
		}
		
		public function isClosed():Boolean
		{
			return m_IsClosed;
		}
		
		public function getModuleView():DisplayObject
		{
			return null;
		}
		
		public function setName(name:String):void
		{
			m_Name = name;
		}
		
		public function getName():String
		{
			return m_Name;
		}
		
		public function clear():void
		{
			m_StartUpParam = null;
			m_UpdateParam = null;
		}
		
		public function dispose():void
		{
			clear();
			if(m_ModuleContext) 
			{
				m_ModuleContext.dispose();
				m_ModuleContext = null;
			}
			disposeView();
			m_ParentInjector = null;
		}
		
		protected function disposeView():void
		{
			DisUtil.stop_mc(m_ModuleView);
			m_ModuleView.removeChildren(0,-1,true);
			m_ModuleView.removeFromParent(true);
			
			m_ParentContainer = null;
			m_ModuleView = null;
		}
		
		protected function onStartUp():void {}
		protected function onClose():void
		{
			m_ModuleView.removeFromParent(true);
		}
		
		protected function initModule(viewCls:Class,contextCls:Class,domain:ApplicationDomain = null,layerEnum:EnumVo = null):void
		{
			m_ModuleView = new viewCls;
			m_ModuleContext = new contextCls(m_ModuleView,m_ParentInjector,domain);
			
			if(LayerMgr.CONTROL_SCREENNAVIGATOR_LAYER)
			{
				LayerMgr.CONTROL_SCREENNAVIGATOR_LAYER.showScreen(m_Name);
			}else{
				if(LayerMgr.MAIN_CONTEXT_LAYER)
				{
					LayerMgr.MAIN_CONTEXT_LAYER.addChild(m_ModuleView);
				}
			}
		}
	}
}