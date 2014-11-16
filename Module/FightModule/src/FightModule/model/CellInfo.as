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
		
		public var m_IsStatble:Boolean = false;
		
		public function setConfig(config:CellConfigInfo,addConfig:CellConfigInfo):void
		{
			m_Config = config;
			m_AddConfig = addConfig;
			
			if(m_Config.stable)
			{
				m_IsStatble = true;
			}else{
				if(m_AddConfig && m_AddConfig.stable)
				{
					m_IsStatble = true;
				}
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
			
			return gridInfo;
		}
	}
}