package 
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import Game.MainRoot;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.SystemUtil;
	import starling.utils.formatString;
	
	import util.Constants;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	
	[SWF(frameRate="60",backgroundColor="0x24211C")]
	public class MagicStone extends Sprite
	{
		[Embed(source="/appicon/DefaultBG@2x.png")]
		private static var BackgroundHD:Class;
		
		public static var APP_RECT:Rectangle;
		private var m_Starling:Starling;
		
		public function MagicStone()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//APP尺寸
			APP_RECT = RectangleUtil.fit(new Rectangle(0,0,Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT),
										 new Rectangle(0,0,stage.fullScreenWidth,stage.fullScreenHeight));
			
			var isIOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			var scaleFactor:int = APP_RECT.width < Constants.STAGE_HEIGHT ? 1 : 2;
			var appDir:File = File.applicationDirectory;
			var assets:AssetManager = new AssetManager(scaleFactor);
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(
				appDir.resolvePath("audio")
				,appDir.resolvePath(formatString("fonts/{0}x", scaleFactor))
				,appDir.resolvePath("icons")
				,appDir.resolvePath("fight")
			);
			
			var backgroundClass:Class = scaleFactor == 1 ? BackgroundHD : BackgroundHD;
			var background:Bitmap = new backgroundClass();
			BackgroundHD = null;
			background.x = APP_RECT.x;
			background.y = APP_RECT.y;
			background.width  = APP_RECT.width;
			background.height = APP_RECT.height;
			background.smoothing = true;
			addChild(background);
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = !isIOS;
			
			m_Starling = new Starling(MainRoot,stage,APP_RECT);
			m_Starling.stage.stageWidth  = Constants.STAGE_WIDTH;
			m_Starling.stage.stageHeight = Constants.STAGE_HEIGHT;
			m_Starling.simulateMultitouch  = false;
			m_Starling.enableErrorChecking = Capabilities.isDebugger;
			m_Starling.showStats = true;
			
			m_Starling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function(event:Object, app:MainRoot):void
				{
					m_Starling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
					
					removeChild(background);
					background = null;
					
					var bgTexture:Texture = Texture.fromEmbeddedAsset(backgroundClass, false, false, scaleFactor);
					app.start(bgTexture,assets);
					m_Starling.start();
				});
			
			if (!SystemUtil.isDesktop)
			{
				NativeApplication.nativeApplication.addEventListener(
					flash.events.Event.ACTIVATE, function (e:*):void { m_Starling.start(); });
				NativeApplication.nativeApplication.addEventListener(
					flash.events.Event.DEACTIVATE, function (e:*):void { m_Starling.stop(true); });
			}
		}
	}
}