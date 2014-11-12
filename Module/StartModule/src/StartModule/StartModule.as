package StartModule  
{
	import feathers.controls.ButtonGroup;
	import feathers.controls.PanelScreen;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	public class StartModule extends PanelScreen
	{
		public function StartModule()
		{
			super();
		}
		
		public var m_ButtonGroup:ButtonGroup;
		
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			
			m_ButtonGroup = new ButtonGroup();
			
			var buttonGroupLayoutData:AnchorLayoutData = new AnchorLayoutData();
			buttonGroupLayoutData.horizontalCenter = 0;
			buttonGroupLayoutData.verticalCenter = 0;
			m_ButtonGroup.layoutData = buttonGroupLayoutData;
			
			addChild(m_ButtonGroup);
		}
	}
}

