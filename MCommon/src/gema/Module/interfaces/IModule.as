package gema.Module.interfaces
{
	
	import org.robotlegs.core.IInjector;
	
	import starling.display.DisplayObject;
	
	public interface IModule extends IDisposeObject
	{
		/**
		 * 模块启动（第一次打开）
		 */
		function startUp(injector:IInjector = null,startUpParameter:Object = null):void;
		function getStartUpParam():Object;
		
		/**
		 * 模块更新（打开已经打开或关闭的）
		 */
		function update(param:Object = null):void;
		function getUpdateParam():Object;
		
		/**
		 * 模块关闭
		 */
		function close():void;
		function isClosed():Boolean;
		
		function getModuleView():DisplayObject;
		function setName(name:String):void;
		function getName():String;
	}
}