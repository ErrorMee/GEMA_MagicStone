package gema.configs
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class WallConfig extends BaseConfig
	{
		public function WallConfig()
		{
			super();
		}
		
		public function getWallConfigInfo(id:String):WallConfigInfo
		{
			return getConfigInfo(id) as WallConfigInfo;
		}
	}
}