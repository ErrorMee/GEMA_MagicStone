package FightModule.model
{

	/**
	 * 创建者: cory
	 * 修改者:
	 * 说明:
	 */
	public class GridUtil
	{
		public static function getIndex(x:int,y:int):int
		{
			var index:int = y * FightConst.X_NUM + x;
			return index;
		}
		
		public static function getGridX(index:int):int
		{
			return index%FightConst.X_NUM;
		}
		
		public static function getGridY(index:int):int
		{
			return index/FightConst.X_NUM;
		}
		
		public static function isAround(preCell:CellInfo,nextCell:CellInfo):Boolean
		{
			if(Math.abs(nextCell.m_XNum - preCell.m_XNum) == 1 || Math.abs(nextCell.m_YNum - preCell.m_YNum) == 1)
			{
				if(Math.abs(nextCell.m_XNum - preCell.m_XNum) > 1 || Math.abs(nextCell.m_YNum - preCell.m_YNum) > 1)
				{
					return false;
				}
				return true;
			}
			return false;
		}
		
	}
}