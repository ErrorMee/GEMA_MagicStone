package gema.Module.core
{
	import feathers.controls.PanelScreen;
	
	import gema.util.Constants;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleContextView extends PanelScreen
	{
		public function ModuleContextView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			setSize(Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT);
		}
	}
}