package gema.structure
{
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class PPoint
	{
		public var m_PreX:int;
		public var m_PreY:int;
		public var m_ToX:int;
		public var m_ToY:int;
		
		public function getXLen():int
		{
			return m_ToX - m_PreX;
		}
		
		public function getYLen():int
		{
			return m_ToY - m_PreY;
		}
	}
}