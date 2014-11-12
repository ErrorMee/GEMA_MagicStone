package gema.Module.interfaces
{
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public interface IDisposeObject
	{
		/**
		 *	清空为初始化状态
		 */
		function clear():void;
		
		/**
		 *	清理对象
		 */
		function dispose():void;
	}
}