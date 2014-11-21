package gema.configs
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class CellConfigInfo extends BaseConfigInfo
	{
		public var name:String;
		
		public var view:String;
		
		public var link:int;
		
		public var stable:int;
		
		public var attach:int;
		
		public var involve_atk:int;
		
		public var involve_def:int;
		
		public var export_type:int;
		
		public var export_value:int;
		
		public var radio:int;
		
		public var bomb:int;
		
		public var desc:String;
		
		public function CellConfigInfo()
		{
			super();
		}
		
		public function isAttachType(attachType:int):Boolean
		{
			if(attach == attachType)
			{
				return true;
			}
			return false;
		}
	}
}