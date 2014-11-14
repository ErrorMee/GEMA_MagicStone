package StartModule
{
	import feathers.controls.ButtonGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import gema.Module.core.ModuleContextView;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class StartView extends ModuleContextView
	{
		public var m_ButtonGroup:ButtonGroup;
		
		public function StartView()
		{
			super();
		}
		
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
			
			this.x = 10;
		}
	}
}