package FightModule.element
{
	import flash.geom.Point;
	
	import FightModule.model.CellInfo;
	import FightModule.model.FightConst;
	
	import gema.configs.CellConfigInfo;
	import gema.util.AssetsUtil;
	import gema.util.DisUtil;
	import gema.util.PosUtil;
	import gema.util.StrUtil;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class CellItem extends Sprite
	{
		private var m_Quad:Quad;
		
		private var m_MC:MovieClip;
		
		private var m_ADDMC:MovieClip;
		
		private var m_Info:CellInfo;
		
		public function CellItem(info:CellInfo)
		{
			super();
			
			m_Info = info.copy();
			
			m_Quad = new Quad(FightConst.CELL_SIZE,FightConst.CELL_SIZE);
			addChild(m_Quad);
			m_Quad.color = 0xCDBE70;
			
			var frames:Vector.<Texture> = AssetsUtil.ASSET.getTextures(StrUtil.getDigitStr("cell_" + info.m_Config.id,0));
			m_MC = new MovieClip(frames,5);
			DisUtil.pivot(m_MC);
			m_MC.x = FightConst.CELL_SIZE/2;
			m_MC.y = FightConst.CELL_SIZE/2;
			addChild(m_MC);
			Starling.juggler.add(m_MC);
			
			if(info.m_AddConfig)
			{
				var addframes:Vector.<Texture> = AssetsUtil.ASSET.getTextures(StrUtil.getDigitStr("cell_" + info.m_AddConfig.id,0));
				m_ADDMC = new MovieClip(frames,5);
				DisUtil.pivot(m_ADDMC);
				m_ADDMC.x = FightConst.CELL_SIZE/2;
				m_ADDMC.y = FightConst.CELL_SIZE/2;
				addChild(m_ADDMC);
				Starling.juggler.add(m_ADDMC);
			}
			
			this.x = FightConst.CELL_GAP + m_Info.m_XNum * FightConst.CELL_FULL_SIZE;
			this.y = FightConst.CELL_GAP + m_Info.m_YNum * FightConst.CELL_FULL_SIZE;
			DisUtil.pivot(this);
			textTest();
		}
		
		private var m_TypeText:TextField;
		private function textTest():void
		{
			m_TypeText = new TextField(20,18,"0","Desyrel",10,0xffffff,true);
			m_TypeText.autoScale = true;
			m_TypeText.hAlign = HAlign.CENTER;
			m_TypeText.vAlign = VAlign.CENTER;
			m_TypeText.fontSize = BitmapFont.NATIVE_SIZE;
			m_TypeText.text = "" + m_Info.m_Type;
			
			DisUtil.pivot(m_TypeText,PosUtil.DIR_CENTER);
			m_TypeText.x = m_MC.x;
			m_TypeText.y = m_MC.y;
			
//			addChild(m_TypeText);
		}
		
		public function changeInfoPos(point:Point):void
		{
			m_Info.m_XNum = point.x;
			m_Info.m_YNum = point.y;
		}
		
		public function getInfo():CellInfo
		{
			return m_Info;
		}
	}
}