package gema.Module.interfaces
{
	import gema.Module.base.ModuleInfo;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public interface IModuleManager
	{
		/**得到模块**/
		function getModule(moduleType:String):IModule;
		
		/**打开模块**/
		function openModule(info:ModuleInfo,callBack:Function = null):void;
		
		/**关闭模块**/
		function closeModule(info:ModuleInfo,callBack:Function = null):void;
		
		/**销毁模块**/
		function destroyModule(info:ModuleInfo,callBack:Function = null):void;
	}
}