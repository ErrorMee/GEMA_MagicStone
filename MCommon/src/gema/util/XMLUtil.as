package gema.util
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class XMLUtil
	{
		public static function checkPropIsTrue(xmlProp:String):Boolean
		{
			if(xmlProp == "0" || xmlProp == "")
			{
				return false;
			}else{
				return (xmlProp == "true") ? true:false;
			}
		}
	}
}