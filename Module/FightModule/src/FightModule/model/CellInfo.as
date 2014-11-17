package FightModule.model
{
	import gema.configs.CellConfigInfo;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	
	public class CellInfo
	{
		public var m_XNum:int;
		public var m_YNum:int;
		public var m_Type:int;
		
		public var m_Config:CellConfigInfo;
		public var m_AddConfig:CellConfigInfo;
		
		public var link:Boolean = false;
		public var stable:Boolean = false;
		public var involve_atk:int = 0;
		public var involve_def:int = 0;
		
		public function setConfig(config:CellConfigInfo,addConfig:CellConfigInfo):void
		{
			m_Config = config;
			m_AddConfig = addConfig;
			
			if(m_Config.stable)
			{
				stable = true;
			}else{
				if(m_AddConfig && m_AddConfig.stable)
				{
					stable = true;
				}
			}
			
			if(m_Config.link)
			{
				if(m_AddConfig)
				{
					if(m_AddConfig.link)
					{
						link = true;
					}
				}else{
					link = true;
				}
			}
			
			involve_atk = config.involve_atk;
			involve_def = config.involve_def;
			if(addConfig)
			{
				involve_atk += addConfig.involve_atk;
				involve_def += addConfig.involve_def;
			}
		}
		
		public function copy():CellInfo
		{
			var gridInfo:CellInfo = new CellInfo();
			gridInfo.m_XNum = m_XNum;
			gridInfo.m_YNum = m_YNum;
			gridInfo.m_Type = m_Type;
			
			gridInfo.m_Config = m_Config;
			gridInfo.m_AddConfig = m_AddConfig;
			
			gridInfo.link = link;
			gridInfo.stable = stable;
			gridInfo.involve_atk = involve_atk;
			gridInfo.involve_def = involve_def;
			
			return gridInfo;
		}
	}
}