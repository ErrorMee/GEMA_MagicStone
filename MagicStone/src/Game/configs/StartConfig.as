package Game.configs
{
	import gema.configs.BaseConfig;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class StartConfig extends BaseConfig
	{
		public var m_HungryZip:Boolean = false;
		
		public var m_HungryPath:String;
		
		public var m_GameVersion:String;
		
		public function StartConfig()
		{
			if(null != g_Instance)
			{
				return;
			}
			g_Instance = this;
		}
		private static var g_Instance:StartConfig;
		public static function GetInstance():StartConfig
		{
			return g_Instance;
		}
	}
}