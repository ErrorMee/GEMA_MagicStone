package FightModule.model2048
{
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import gema.util.AssetsUtil;
	import gema.util.PosUtil;
	import gema.util.DisUtil;
	import gema.util.StrUtil;
	
	public class Grid2048Cell extends Sprite
	{
		private var m_Quad:Quad;
		
		private var m_MC:MovieClip;
		
		private var m_ValueText:TextField;
		
		private var m_Grid:Grid2048Info;
		
		public function Grid2048Cell(w:Number,h:Number,grid:Grid2048Info)
		{
			super();
			m_Grid = grid;
			m_Quad = new Quad(w,h);
			addChild(m_Quad);
			m_Quad.color = 0xCDBE70;
			var frames:Vector.<Texture> = AssetsUtil.ASSET.getTextures(StrUtil.getDigitStr(grid.m_Type,0));
			m_MC = new MovieClip(frames,5);
			
			DisUtil.pivot(m_MC);
			m_MC.x = w/2;
			m_MC.y = h/2;
			addChild(m_MC);
			Starling.juggler.add(m_MC);
			
			m_ValueText = new TextField(20,20,"0","Desyrel",10,0x00ff00,true);
			m_ValueText.autoScale = true;
			m_ValueText.hAlign = HAlign.CENTER;
			m_ValueText.vAlign = VAlign.CENTER;
			m_ValueText.fontSize = BitmapFont.NATIVE_SIZE;
			m_ValueText.text = "" + grid.m_Value;
			
			DisUtil.pivot(m_ValueText,PosUtil.DIR_CENTER);
			m_ValueText.x = m_MC.x;
			m_ValueText.y = m_MC.y;
			
			this.width = w;
			this.height = h;
			
			addChild(m_ValueText);
		}
	}
}