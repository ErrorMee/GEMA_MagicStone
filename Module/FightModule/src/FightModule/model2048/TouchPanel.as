package FightModule.model2048
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import FightModule.model.FightConst;
	
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import util.PosUtil;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class TouchPanel extends ScrollContainer
	{
		public function TouchPanel()
		{
			super();
			addEventListener( FeathersEventType.INITIALIZE, initializeHandler );
		}
		
		private function initializeHandler( event:Event ):void
		{
			removeEventListener( FeathersEventType.INITIALIZE, initializeHandler );
			
			initBg();
			initMover();
			addEvent();
		}
		
		private var m_Bg:Quad;
		private function initBg():void
		{
			m_Bg = new Quad(FightConst.BATTLE_SIZE,FightConst.BATTLE_SIZE);
			m_Bg.color = 0xEE5C42;
			m_Bg.alpha = 0;
			addChild(m_Bg);
		}
		
		private var m_Mover:Image;
		private function initMover():void
		{
			var fShap:flash.display.Sprite = new flash.display.Sprite;
			fShap.graphics.clear();
			fShap.graphics.beginFill(0xA52A2A,.4);
			fShap.graphics.drawCircle(0,0,10);
			fShap.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(fShap.width,fShap.height,true,0);
			var matrix:Matrix = new Matrix;
			matrix.translate(fShap.width/2,fShap.height/2);
			bmd.draw(fShap,matrix);
			var texture:Texture = Texture.fromBitmapData(bmd);
			m_Mover = new Image(texture);
		}
		
		private function addEvent():void
		{
			addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private var m_StartPos:Point;
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if(touch)
			{
				var point:Point = touch.getLocation(this);
				
				if(touch.phase == TouchPhase.BEGAN)
				{
					m_StartPos = point;
					addChild(m_Mover);
					m_Mover.x = point.x - m_Mover.width/2;
					m_Mover.y = point.y - m_Mover.height/2;
				}
				
				if(touch.phase == TouchPhase.ENDED)
				{
					removeChild(m_Mover);
					
					if(m_StartPos)
					{
						var dir:int = PosUtil.get4Dir(m_StartPos.x,m_StartPos.y,point.x,point.y);
					}
					
					m_StartPos = null;
				}
				
				if(touch.phase == TouchPhase.MOVED)
				{
					m_Mover.x = point.x - m_Mover.width/2;
					m_Mover.y = point.y - m_Mover.height/2;
				}
			}
		}
	}
}