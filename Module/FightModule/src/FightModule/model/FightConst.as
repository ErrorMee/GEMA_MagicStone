package FightModule.model
{
	import gema.util.Constants;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class FightConst
	{
		public static const CELL_SIZE_HALF:int = 16;
		
		public static const CELL_SIZE:int = CELL_SIZE_HALF*2;
		
		public static const CELL_GAP:int = 1;
		
		public static const CELL_FULL_SIZE_HALF:int = CELL_SIZE_HALF + CELL_GAP;
		
		public static const CELL_FULL_SIZE:int = CELL_FULL_SIZE_HALF * 2;
		
		public static const X_NUM:int = 9;
		
		public static const BATTLE_SIZE:int = CELL_FULL_SIZE * X_NUM;
		
		public static const BATTLE_GAP:int = Constants.STAGE_WIDTH - BATTLE_SIZE;
		
		/**
		 * 左下方有空位
		 */
		public static const LEFT_UNSTABLE:int = -1;
		/**
		 * 右下方有空位
		 */
		public static const RIGHT_UNSTABLE:int = 1;
		/**
		 * 稳定
		 */
		public static const STABLE:int = 0;
		
		/**
		 * 行为速度
		 */
		public static const BEHAVIOR_SPEED:Number = 0.32;
	}
}