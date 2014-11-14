package gema.configs
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModuleConfig extends BaseConfig
	{
		public function ModuleConfig()
		{
			super();
		}
		
		public function getModuleDevName(id:Object):String
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
			
			var moduleConfigInfo:ModuleConfigInfo = getConfigInfo(idString) as ModuleConfigInfo;
			
			if(moduleConfigInfo)
			{
				return moduleConfigInfo.dev_name;
			}
			return null;
		}
	}
}