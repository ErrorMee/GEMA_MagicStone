package FightModule.panel
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import FightModule.model.FightConst;
	
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class LinePanel extends ScrollContainer
	{
		public var m_Shape:Shape;
		public var m_Image:Image;
		
		public var m_CellSize:int;
		public var m_OffsetSize:int;
		
		public function LinePanel()
		{
			super();
			addEventListener( FeathersEventType.INITIALIZE, initializeHandler );
		}
		
		private function initializeHandler( event:Event ):void
		{
			removeEventListener( FeathersEventType.INITIALIZE, initializeHandler );
			this.touchable = false;
			
			m_Shape = new Shape;
			var bmpd:BitmapData = new BitmapData(1,1);
			var texture:Texture = Texture.fromBitmapData(bmpd,false,true);
			m_Image = new Image(texture);
			
			m_CellSize = FightConst.CELL_SIZE + FightConst.CELL_GAP*2;
			m_OffsetSize = m_CellSize/2;
		}
		
	}
}