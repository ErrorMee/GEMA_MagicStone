package FightModule.panel
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import FightModule.model.FightConst;
	
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class GridPanel extends ScrollContainer
	{
		public var m_MoveLayer:Sprite;
		public var m_Mover:Image;
		
		public function GridPanel()
		{
			super();
			addEventListener( FeathersEventType.INITIALIZE, initializeHandler );
		}
		
		private function initializeHandler( event:Event ):void
		{
			removeEventListener( FeathersEventType.INITIALIZE, initializeHandler );
			
			initBgGrid();
			
			initMover();
			
			addEvent();
		}
		
		private function initBgGrid():void
		{
			var bigBg:Quad = new Quad(FightConst.BATTLE_SIZE,FightConst.BATTLE_SIZE);
			bigBg.color = 0xB4EEB4;
			addChild(bigBg);
			
			for(var i:int = 0;i<FightConst.X_NUM;i++)
			{
				for(var j:int = 0;j<FightConst.X_NUM;j++)
				{
					var bgCell:Quad = new Quad(FightConst.CELL_SIZE,FightConst.CELL_SIZE);
					bgCell.color = 0xF4F4F4;
					bgCell.x = FightConst.CELL_GAP + j * (FightConst.CELL_SIZE + FightConst.CELL_GAP * 2);
					bgCell.y = FightConst.CELL_GAP + i * (FightConst.CELL_SIZE + FightConst.CELL_GAP * 2);
					addChild(bgCell);
				}
			}
			
			if(m_MoveLayer == null)
			{
				m_MoveLayer = new Sprite;
				addChild(m_MoveLayer);
			}
		}
		
		private function addEvent():void
		{
		}
		
		private function initMover():void
		{
			var shape:Shape = new Shape;
			var g:Graphics = shape.graphics;
			g.clear();
			g.beginFill(0xA52A2A,.4);
			g.drawCircle(0,0,10);
			g.endFill();
			
			var bmd:BitmapData = new BitmapData(shape.width,shape.height,true,0);
			var matrix:Matrix = new Matrix;
			matrix.translate(shape.width/2,shape.height/2);
			bmd.draw(shape,matrix);
			var texture:Texture = Texture.fromBitmapData(bmd);
			m_Mover = new Image(texture);
		}
		
	}
}