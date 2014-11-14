package StartModule
{
	import feathers.controls.Button;
	import feathers.data.ListCollection;
	
	import gema.Module.core.ModuleMediator;
	import gema.configs.ModuleConfig;
	
	import starling.events.Event;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class StartMediator extends ModuleMediator
	{
		[Inject]
		public var i_ModuleConfig:ModuleConfig;
		
		public function StartMediator()
		{
			super();
		}
		
		private function get view():StartView
		{
			return getViewComponent() as StartView;
		}
		
		override protected function initView():void
		{
			view.headerProperties.title = "START";
			
			view.m_ButtonGroup.dataProvider = new ListCollection(
				[{ label: "Through", triggered: onTriggered },{ label: "Dekaron", triggered: onTriggered }]);
		}
		
		private function onTriggered(event:Event):void
		{
			var button:Button = Button(event.currentTarget);
			if(button.label == "Through")
			{
				openModule(i_ModuleConfig.getModuleDevName(10002));
			}
		}
	}
}