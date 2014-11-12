package gema.structure
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class EnumVo
	{
		public var m_Name:String = null;
		public var m_ID:int;
		public var m_Value:int;
		
		/** 扩展 */
		public var m_Array:Array = null;
		
		public function EnumVo(name:String = null, id:int = 0, value:int = 0, array:Array = null)
		{
			m_Name = name;
			m_ID = id;
			m_Value = value;
			m_Array = array;
		}
		
		public function setName(name:String):EnumVo
		{
			m_Name = name;
			return this;
		}
		
		public function setID(id:int):EnumVo
		{
			m_ID = id;
			return this;
		}
		
		public function setValue(value:int):EnumVo
		{
			m_Value = value;
			return this;
		}
		
		public function setArray(array:Array):EnumVo
		{
			m_Array = array;
			return this;
		}
		
		public static function sortOnValue(a:EnumVo, b:EnumVo):Number 
		{
			var aPrice:int = a.m_Value;
			var bPrice:int = b.m_Value;
			
			if(aPrice > bPrice) {
				return 1;
			} else if(aPrice < bPrice) {
				return -1;
			} else  {
				return 0;
			}
		}
		
		public static function sortOnID(a:EnumVo, b:EnumVo):Number 
		{
			var aPrice:int = a.m_ID;
			var bPrice:int = b.m_ID;
			
			if(aPrice > bPrice) {
				return 1;
			} else if(aPrice < bPrice) {
				return -1;
			} else  {
				return 0;
			}
		}
	}
}