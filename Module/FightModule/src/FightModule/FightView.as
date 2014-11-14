package FightModule
{
	import FightModule.panel.GridPanel;
	import FightModule.panel.LinePanel;
	
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import gema.Module.core.ModuleContextView;
	
	import starling.events.Event;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class FightView extends ModuleContextView
	{
		public var m_GridPanel:GridPanel;
		
		public var m_LinePanel:LinePanel;
		
		public function FightView()
		{
			super();
			
			addEventListener( FeathersEventType.INITIALIZE, initializeHandler );
		}
		
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			
			m_GridPanel = new GridPanel;
			var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData;
			m_GridPanel.layoutData = anchorLayoutData;
			anchorLayoutData.horizontalCenter = 0;
			//			anchorLayoutData.bottom = 7;
			//			anchorLayoutData.top = 128;
			
			m_LinePanel = new LinePanel;
			m_LinePanel.layoutData = anchorLayoutData;
		}
		
		private function initializeHandler( event:Event ):void
		{
			removeEventListener( FeathersEventType.INITIALIZE, initializeHandler );
			addChild(m_GridPanel);
			addChild(m_LinePanel);
		}
	}
}