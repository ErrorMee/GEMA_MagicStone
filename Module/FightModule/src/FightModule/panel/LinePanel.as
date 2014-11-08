package FightModule.panel
{
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	
	import FightModule.model.CellInfo;
	import FightModule.model.FightConst;
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;
	
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
		private var m_GridModel:GridModel;
		
		private var m_Shape:Shape;
		private var m_Image:Image;
		
		private var m_CellSize:int;
		private var m_OffsetSize:int;
		
		public function LinePanel()
		{
			super();
			addEventListener( FeathersEventType.INITIALIZE, initializeHandler );
		}
		
		private function initializeHandler( event:Event ):void
		{
			removeEventListener( FeathersEventType.INITIALIZE, initializeHandler );
			m_GridModel = GridModel.getInstance();
			this.touchable = false;
			
			m_Shape = new Shape;
			var bmpd:BitmapData = new BitmapData(1,1);
			var texture:Texture = Texture.fromBitmapData(bmpd,false,true);
			m_Image = new Image(texture);
			
			m_CellSize = FightConst.CELL_SIZE + FightConst.CELL_GAP*2;
			m_OffsetSize = m_CellSize/2;
			
			m_GridModel.addEventListener(GridEvent.GRID_LINE_CHANGE,onLineChange);
		}
		
		private function onLineChange(e:GridEvent):void
		{
			updateLine();
		}
		
		private function updateLine():void
		{
			var g:Graphics = m_Shape.graphics;
			g.clear();
			g.lineStyle(1,0xEE5C42,1,true,LineScaleMode.NONE,CapsStyle.ROUND);
			
			var lineCells:Vector.<CellInfo> = m_GridModel.getLineCells();
			if(lineCells)
			{
				var i:int;
				var endIndex:int = lineCells.length - 1;
				
				g.moveTo(0,0);
				g.lineTo(0,FightConst.BATTLE_SIZE);
				g.lineTo(FightConst.BATTLE_SIZE,FightConst.BATTLE_SIZE);
				g.lineTo(FightConst.BATTLE_SIZE,0);
				g.lineTo(0,0);
				
				g.lineStyle(3,0xFF4500,1,true,LineScaleMode.NONE,CapsStyle.ROUND);
				
				for(i = 0;i<endIndex;i++)
				{
					var moveToCell:CellInfo = lineCells[i];
					var lineToCell:CellInfo = lineCells[i + 1];
					
					g.moveTo(moveToCell.m_XNum*m_CellSize + m_OffsetSize,moveToCell.m_YNum*m_CellSize + m_OffsetSize);
					g.lineTo(lineToCell.m_XNum*m_CellSize + m_OffsetSize,lineToCell.m_YNum*m_CellSize + m_OffsetSize);
				}
				
				var bmpd:BitmapData = new BitmapData(m_Shape.width,m_Shape.height,true,0);
				bmpd.draw(m_Shape);
				
				var texture:Texture = Texture.fromBitmapData(bmpd,false,true);
				if(m_Image)
				{
					m_Image.removeFromParent(true);
					m_Image = null;
				}
				m_Image = new Image(texture);
				addChild(m_Image);
			}
		}
	}
}