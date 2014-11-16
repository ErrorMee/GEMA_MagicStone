package gema.configs
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class CellConfig extends BaseConfig
	{
		private var m_CellArrs:Array = [];
		
		public function CellConfig()
		{
			super();
		}
		
		override public function parseXML(data:XML, cls:Class, asyn:Boolean=false):void
		{
			super.parseXML(data, cls, asyn);
			groupCells();
		}
		
		public function getCellConfigInfo(id:String):CellConfigInfo
		{
			return getConfigInfo(id) as CellConfigInfo;
		}
		
		public function getConfigInfosByAttachType(attachType:int):Array
		{
			var arr:Array = [];
			var configInfos:Array = getConfigInfos(true);
			for each(var info:CellConfigInfo in configInfos)
			{
				if(info.isAttachType(attachType))
				{
					arr.push(info);
				}
			}
			return arr;
		}
		
		private function groupCells():Array
		{
			m_CellArrs = [];
			var i:int = 0;
			
			var configInfos:Array = getConfigInfos(true);
			var toAttachs:Array = getConfigInfosByAttachType(CellAttachTypeEnum.TO);
			var beAttachs:Array = getConfigInfosByAttachType(CellAttachTypeEnum.BE);
			
			var configInfo:CellConfigInfo;
			for(i = 0;i<configInfos.length;i++)
			{
				configInfo = configInfos[i];
				
				if(!configInfo.isAttachType(CellAttachTypeEnum.TO))
				{
					m_CellArrs.push([configInfo]);
				}
			}
			
			for(i = 0;i<beAttachs.length;i++)
			{
				for(var j:int = 0;j<toAttachs.length;j++)
				{
					m_CellArrs.push([beAttachs[i],toAttachs[j]]);
				}
			}
			return m_CellArrs;
		}
		
		public function getGroupCellss():Array
		{
			return m_CellArrs;
		}
	}
}