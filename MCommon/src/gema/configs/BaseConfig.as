package gema.configs
{
	import flash.utils.Dictionary;
	
	import gema.structure.HashMap;
	import gema.util.SortUtil;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class BaseConfig
	{
		private var m_ConfigInfoList:HashMap = new HashMap;
		
		private var m_IsAsyn:Boolean = false;
		private var m_XMLList:XMLList;
		private var m_Class:Class;
		
		public function parseXML(data:XML,cls:Class,asyn:Boolean = false):void
		{
			var length:int = data.children().length();
			if(length <= 0) 
			{
				trace("配置数据为空：" + this);
				return;
			}
			m_IsAsyn = asyn;
			m_Class = cls;
			if(!m_IsAsyn)
			{
				var dataList:XMLList = data.elements(data.children()[0].name());
				var len:uint = dataList.length();
				for(var i:uint = 0; i < len; i++)
				{
					singleParse(XML(dataList[i]));
				}
			}else{
				m_XMLList = data.elements(data.children()[0].name());
			}
		}
		
		/**
		 * @param integrity 完整性检查 尽量少用
		 */
		public function getConfigList(integrity:Boolean = false):HashMap
		{
			if(integrity)
			{
				if(m_IsAsyn)
				{
					var len:uint = m_XMLList.length();
					for(var i:uint = 0; i < len; i++)
					{
						singleParse(XML(m_XMLList[i]));
					}
				}
			}
			return m_ConfigInfoList;
		}
		
		/**
		 * @param integrity 完整性检查 尽量少用
		 */
		public function getConfigDic(integrity:Boolean = false):Dictionary
		{
			return getConfigList(integrity).dict;
		}
		
		public function getConfigInfos(sort:Boolean = false):Array
		{
			var infos:Array = [];
			var dic:Dictionary = m_ConfigInfoList.dict;
			for each(var info:BaseConfigInfo in dic)
			{
				if(info)
				{
					infos.push(info);
				}
			}
			if(sort)
			{
				infos.sort(SortUtil.ASCENDING);
			}
			return infos;
		}
		
		public function getConfigInfo(id:Object):BaseConfigInfo
		{
			if(id == null)
			{
				return null;
			}
			var idString:String = id.toString();
			if(idString == "")
			{
				return null;
			}
			
			if(m_ConfigInfoList.get(idString) == null)
			{
				if(m_IsAsyn)
				{
					var singleActionList:XMLList = m_XMLList.(@id == idString);
					if(singleActionList == null)
					{
						return null;
					}
					var singleAction:XML = singleActionList[0];
					singleParse(singleAction);
					delete m_XMLList.(@id == idString)[0];
				}
			}
			
			return m_ConfigInfoList.get(idString) as BaseConfigInfo;
		}
		
		private function singleParse(xml:XML):void
		{
			var configInfo:BaseConfigInfo = new m_Class;
			configInfo.fillXml(xml);
			if(m_ConfigInfoList.containsKey(configInfo.getKey()))
			{
				trace("配置ID号重复：" + configInfo.getKey() + this);
			}
			else
			{
				m_ConfigInfoList.put(configInfo.getKey(),configInfo);
			}
		}
	}
}