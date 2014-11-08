package FightModule.model2048
{

	public class Grid2048Info
	{
		public var m_Pos:uint;//0-15
		public var m_Value:uint;//0-16
		public var m_Type:String = Grid2048TypeEnum.TYPE_ATK;//GridTypeEnum
		
		public function copy():Grid2048Info
		{
			var gridInfo:Grid2048Info = new Grid2048Info();
			gridInfo.m_Pos = m_Pos;
			gridInfo.m_Value = m_Value;
			gridInfo.m_Type = m_Type;
			return gridInfo;
		}
	}
}