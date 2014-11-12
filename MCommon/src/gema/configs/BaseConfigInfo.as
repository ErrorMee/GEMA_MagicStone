package gema.configs
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class BaseConfigInfo
	{
		public var id:String;
		
		public function BaseConfigInfo()
		{
		}
		
		/**
		 * xml赋值
		 * @param	obj
		 */
		public function fillXml(xmlObj:XML):void
		{
			if(xmlObj == null) return ;
			var xmlAttrs:XMLList = xmlObj.attributes();
			var len:int = xmlAttrs.length();
			for(var i:int=0;i<len;i++)
			{
				var xmlAttr:XML = xmlAttrs[i];
				var propertyname:String = xmlAttr.name();
				if(!hasOwnProperty(propertyname)) continue;
				this[propertyname] = xmlAttr;
			}
		}
		
		public function getKey():String
		{
			return id;
		}
	}
}