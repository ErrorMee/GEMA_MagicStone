package Game.command
{
	
	import Game.configs.StartConfig;
	import Game.configs.StartConfigInfo;
	import Game.MainContextEvent;
	
	import gema.Module.core.ModuleCommand;
	import gema.configs.BaseConfig;
	import gema.util.AssetsUtil;
	import gema.util.Constants;
	import gema.util.XMLUtil;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class InitConfigCommand extends ModuleCommand
	{
		public function InitConfigCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var startXml:XML = AssetsUtil.ASSET.getXml("start");
			var gameStartConfig:StartConfig = new StartConfig;
			gameStartConfig.m_HungryZip = XMLUtil.checkPropIsTrue(startXml.hungry.@zip);
			gameStartConfig.m_HungryPath = startXml.hungry.@path;
			gameStartConfig.m_GameVersion = startXml.game.@version;
			gameStartConfig.parseXML(startXml.hungry[0],StartConfigInfo);
			injector.mapValue(StartConfig,gameStartConfig);
			AssetsUtil.ASSET.removeXml("start",true);
			
			hungryConfig();
		}
		
		private function hungryConfig():void
		{
			var gameStartConfig:StartConfig = injector.getInstance(StartConfig);
			var gameStartConfigInfo:StartConfigInfo = gameStartConfig.getConfigList().shift() as StartConfigInfo;
			if(gameStartConfigInfo)
			{
				var ConfigCls:Class = Constants.getClassByName(gameStartConfigInfo.className);
				if(ConfigCls == null)
				{
					throw new ArgumentError(gameStartConfigInfo.className + " 未定义");
					return;
				}
				
				if(gameStartConfigInfo.isXml())
				{
					var configInstance:BaseConfig = new ConfigCls as BaseConfig;
					if(configInstance == null)
					{
						trace("类继承错误：" + gameStartConfigInfo.className);
						return;
					}
					
					var ConfigInfoCls:Class = Constants.getClassByName(gameStartConfigInfo.className + "Info");
					
					trace("analyze XML：" + gameStartConfigInfo.className);
					var xml:XML = AssetsUtil.ASSET.getXml(gameStartConfigInfo.getShortName());
					configInstance.parseXML(xml,ConfigInfoCls,Boolean(gameStartConfigInfo.asyn));
					injector.mapValue(ConfigCls,configInstance);
					AssetsUtil.ASSET.removeXml(gameStartConfigInfo.getShortName(),true);
					
					if(gameStartConfig.getConfigList().length())
					{
						hungryConfig();
					}else{
						dispatch(new MainContextEvent(MainContextEvent.INIT_MODULE));
					}
					
				}else{
					throw new ArgumentError(gameStartConfigInfo.className + " 不是xml");
				}
			}
		}
	}
}
