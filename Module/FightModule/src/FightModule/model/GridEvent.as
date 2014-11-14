package FightModule.model
{
	import gema.Module.base.FlashEvent;

	/**
	 * 创建者: cory
	 * 修改者:
	 * 说明:
	 */
	public class GridEvent extends FlashEvent
	{
		public static const GRID_CHANGE:String = "grid_change";
		
		public static const GRID_LOAD_COMPLETE:String = "grid_load_complete";
		
		public static const GRID_LINE_CHANGE:String = "grid_line_change";
		
		public function GridEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, data, bubbles);
		}
	}
}