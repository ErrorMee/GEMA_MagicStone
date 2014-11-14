package ControlModule
{
	import ControlModule.view.MainNavigator;
	
	import starling.display.Sprite;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ControlView extends Sprite
	{
		public var m_MainNavigator:MainNavigator;
		
		public function ControlView()
		{
			super();
			init();
		}
		
		private function init():void
		{
			m_MainNavigator = new MainNavigator();
			addChild(m_MainNavigator);
//			var text:TextField = new TextField(100,100,"control");
//			text.autoScale = true;
//			text.border = true;
//			addChild(text);
		}
		
	}
}