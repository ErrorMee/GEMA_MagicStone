package Game
{
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;
	
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.themes.MetalWorksMobileTheme;
	
	import gema.util.AssetsUtil;
	import gema.util.Constants;
	import gema.util.DisUtil;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class MainRoot extends Sprite
	{
		private var m_MainContext:MainContext;
		
		public function MainRoot()
		{
			super();
		}
		
		public function start(background:Texture, assets:AssetManager):void
		{
			//startup feather theme
			new MetalWorksMobileTheme();
			//startup robotlegs
			m_MainContext = new MainContext(this);
			//bg
			var bgImage:Image = new Image(background);
			bgImage.smoothing = TextureSmoothing.NONE;
//			addChild(bgImage);
			
			//main loading bar
			m_ProgressBar = new ProgressBar;
			m_ProgressBar.direction = ProgressBar.DIRECTION_HORIZONTAL;
			m_ProgressBar.minimum = 0;
			m_ProgressBar.maximum = 100;
			m_ProgressBar.value = 0;
			addChild(m_ProgressBar);
			m_ProgressBar.validate();
			DisUtil.pivot(m_ProgressBar);
			DisUtil.move(m_ProgressBar,Constants.STAGE_WIDTH_HALF,Constants.STAGE_HEIGHT_HALF);
			
			m_Label = new Label();	
			Callout.show(m_Label, m_ProgressBar);
			m_Label.text = "Loading. " + m_CrtValue + "/100.";
			
			//loading assets
			AssetsUtil.ASSET = assets;
			assets.loadQueue(function onProgress(ratio:Number):void
			{
				m_EndValue = int(ratio*100);
				if(m_EndValue >= 100)
				{
					Starling.juggler.delayCall(function():void
					{
						m_ProgressBar.removeFromParent(true);
						
						m_MainContext.startup();
						
						// now would be a good time for a clean-up 
						System.pauseForGCIfCollectionImminent(0);
						System.gc();
					}, 0.15);
				}
			});
			
//			m_Timer.addEventListener(TimerEvent.TIMER,onTimer);
//			m_Timer.start();
		}
		
		private var m_ProgressBar:ProgressBar;
		private var m_Timer:Timer = new Timer(20);
		private var m_EndValue:int;
		private var m_CrtValue:int;
		private var m_Label:Label;
		private function onTimer(e:TimerEvent):void
		{
			if(m_CrtValue < m_EndValue)
			{
				m_CrtValue ++;
				m_ProgressBar.value = m_CrtValue;
				m_Label.text = "Loading. " + m_CrtValue + "/100.";
			}
			if(m_CrtValue >= 100)
			{
				Starling.juggler.delayCall(function():void
				{
					m_ProgressBar.removeFromParent(true);
					
					m_MainContext.startup();
					
					// now would be a good time for a clean-up 
					System.pauseForGCIfCollectionImminent(0);
					System.gc();
				}, 0.15);
				
				m_Timer.stop();
				m_Timer.removeEventListener(TimerEvent.TIMER,onTimer);
				m_Timer = null;
			}
		}

	}
}