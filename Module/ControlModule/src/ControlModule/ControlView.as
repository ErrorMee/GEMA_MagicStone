package ControlModule
{
	import ControlModule.view.MainNavigator;
	
	import feathers.controls.ScreenNavigatorItem;
	
	import gema.Module.core.ModuleContextView;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ControlView extends ModuleContextView
	{
		public var m_MainNavigator:MainNavigator;
		
		public function ControlView()
		{
			super();
		}
		
		override protected function init():void
		{
			m_MainNavigator = new MainNavigator();
			addChild(m_MainNavigator);
		}
		
		public function addScreen(name:String,screenCls:Class):void
		{
			m_MainNavigator.m_Navigator.addScreen(name,new ScreenNavigatorItem(screenCls));
		}
		
		public function showScreen(name:String):void
		{
			m_MainNavigator.m_Navigator.showScreen(name);
		}
	}
}