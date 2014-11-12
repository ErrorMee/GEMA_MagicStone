package gema.configs
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleConfigInfo extends BaseConfigInfo
	{
		public var name:String;
		
		public var dev_name:String;
		
		public function ModuleConfigInfo()
		{
			super();
		}
		
		public function getClassName():String
		{
			return dev_name + "Module." + dev_name + "Module";
		}
	}
}