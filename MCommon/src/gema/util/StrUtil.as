package gema.util
{
	public class StrUtil
	{
		/**
		 * 数字转换成获得固定长度的字符串 ps: 10 > "0010"
		 * @param prefixStr
		 * @param id
		 * @param digit
		 * @param linkStr
		 * @return 
		 */
		public static function getDigitStr(prefixStr:String,num:uint,digit:int = 4,linkStr:String = ""):String
		{
			var idStr:String = "" + num;
			
			if(idStr.length > digit)
			{
				throw new Error(num + "位数大于指定的" + digit);
			}else{
				var left0Num:int = digit - idStr.length;
				while(left0Num)
				{
					left0Num --;
					idStr = "0" + idStr;
				}
			}
			return prefixStr + linkStr + idStr;
		}
	}
}