package
{
	import Module.ModuleEvent;
	
	import feathers.controls.Button;
	import feathers.data.ListCollection;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	import starling.events.Event;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class StartMediator extends StarlingMediator
	{
		public function StartMediator()
		{
			super();
		}
		
		private function get view():StartModule
		{
			return getViewComponent() as StartModule;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			view.headerProperties.title = "START";
			
			view.m_ButtonGroup.dataProvider = new ListCollection(
			[{ label: "Through", triggered: onTriggered },{ label: "Dekaron", triggered: onTriggered }]);
		}
		
		private function onTriggered(event:Event):void
		{
			var button:Button = Button(event.currentTarget);
			if(button.label == "Through")
			{
				dispatch(new ModuleEvent(ModuleEvent.OPEN_MODULE,"FightModule"));
			}
		}
	}
}