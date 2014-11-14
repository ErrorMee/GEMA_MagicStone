package FightModule.panel
{
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	
	import FightModule.model.CellInfo;
	import FightModule.model.FightConst;
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;
	
	import gema.Module.core.ModuleMediator;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class LineMediator extends ModuleMediator
	{
		[Inject]
		public var i_GridModel:GridModel;
		
		public function LineMediator()
		{
			super();
		}
		
		private function get view():LinePanel
		{
			return getViewComponent() as LinePanel;
		}
		
		override protected function initEvent():void
		{
			i_GridModel.addEventListener(GridEvent.GRID_LINE_CHANGE,onLineChange);
		}
		
		private function onLineChange(e:GridEvent):void
		{
			updateLine();
		}
		
		private function updateLine():void
		{
			var g:Graphics = view.m_Shape.graphics;
			g.clear();
			g.lineStyle(1,0xEE5C42,1,true,LineScaleMode.NONE,CapsStyle.ROUND);
			
			var lineCells:Vector.<CellInfo> = i_GridModel.getLineCells();
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
					
					g.moveTo(moveToCell.m_XNum*view.m_CellSize + view.m_OffsetSize,moveToCell.m_YNum*view.m_CellSize + view.m_OffsetSize);
					g.lineTo(lineToCell.m_XNum*view.m_CellSize + view.m_OffsetSize,lineToCell.m_YNum*view.m_CellSize + view.m_OffsetSize);
				}
				
				var bmpd:BitmapData = new BitmapData(view.m_Shape.width,view.m_Shape.height,true,0);
				bmpd.draw(view.m_Shape);
				
				var texture:Texture = Texture.fromBitmapData(bmpd,false,true);
				if(view.m_Image)
				{
					view.m_Image.texture.dispose();
					view.m_Image.removeFromParent(true);
					view.m_Image = null;
				}
				view.m_Image = new Image(texture);
				view.addChild(view.m_Image);
			}
		}
	}
}