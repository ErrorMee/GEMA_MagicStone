package FightModule.model
{
	import gema.structure.PPoint;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class AnimationModel
	{
		public static var RUNING:Boolean = false;
		
		public static function getInstance():AnimationModel
		{
			return _instance;
		}
		private static  var _instance:AnimationModel = new AnimationModel();
		public function AnimationModel()
		{
			if(_instance)
			{
				throw new Error("只能用getInstance()来获取实例");
			}
		}
		
		private var m_LineCells:Vector.<CellInfo> = new Vector.<CellInfo>;
		
		public function line(cell:CellInfo):void
		{
			m_LineCells.push(cell.copy());
		}
		
		public function getLineCells():Vector.<CellInfo>
		{
			return m_LineCells;
		}
		
		private var m_Moves:Array = [];
		public function addMove(arr:Array):void
		{
			var i:int = 0;
			var newArr:Array = [];
			for(;i<arr.length;i++)
			{
				var pp:PPoint = arr[i];
				if((pp.m_PreX != pp.m_ToX) || (pp.m_PreY != pp.m_ToY))
				{
					newArr.push(pp);
				}
			}
			if(newArr.length)
			{
				m_Moves.push(newArr);
			}
		}
		
		public function getMoves():Array
		{
			return m_Moves;
		}
		
		public function clear():void
		{
			m_LineCells = new Vector.<CellInfo>;
			m_Moves = [];
		}
	}
}