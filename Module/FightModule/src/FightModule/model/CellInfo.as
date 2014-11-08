package FightModule.model
{
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
		public var m_Value:int;
		public var m_Type:int;
		
		public function copy():CellInfo
		{
			var gridInfo:CellInfo = new CellInfo();
			gridInfo.m_XNum = m_XNum;
			gridInfo.m_YNum = m_YNum;
			gridInfo.m_Value = m_Value;
			gridInfo.m_Type = m_Type;
			return gridInfo;
		}
	}
}