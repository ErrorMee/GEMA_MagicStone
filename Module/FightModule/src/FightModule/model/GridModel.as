package FightModule.model
{
	import gema.configs.CellConfig;
	import gema.structure.ModelActor;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	
	public class GridModel extends ModelActor
	{
		[Inject]
		public var i_AnimationModel:AnimationModel;
		[Inject]
		public var i_CellConfig:CellConfig;
		
		public var m_ID:int;
		
		public var m_Cells:Vector.<CellInfo> = new Vector.<CellInfo>;
		
		public var m_LineCells:Vector.<CellInfo> = new Vector.<CellInfo>;
		
		public var m_LastCell:CellInfo;
		
		public function getCell(x:int,y:int):CellInfo
		{
			var i:int = 0;
			for(;i<m_Cells.length;i++)
			{
				var cellInfo:CellInfo = m_Cells[i];
				if(cellInfo.m_XNum == x && cellInfo.m_YNum == y)
				{
					return cellInfo;
				}
			}
			return null;
		}
		
		public function deleteCell(cell:CellInfo):void
		{
			var index:int = m_Cells.indexOf(cell);
			if(index >= 0)
			{
				m_Cells.splice(index,1);
			}
		}
		
		public function getCellsByXNum(x:int,minY:int = 0,maxY:int = FightConst.X_NUM):Vector.<CellInfo>
		{
			var cells:Vector.<CellInfo> = new Vector.<CellInfo>;
			var y:int = minY;
			for(;y<maxY;y++)
			{
				var cellInfo:CellInfo = getCell(x,y);
				if(cellInfo)
				{
					cells.push(cellInfo);
				}
			}
			return cells;
		}
		
		public function getCellsByYNum(y:int,minX:int = 0,maxX:int = FightConst.X_NUM):Vector.<CellInfo>
		{
			var cells:Vector.<CellInfo> = new Vector.<CellInfo>;
			var x:int = minX;
			for(;x<maxX;x++)
			{
				var cellInfo:CellInfo = getCell(x,y);
				if(cellInfo)
				{
					cells.push(cellInfo);
				}
			}
			return cells;
		}
		
		public function getLineEnd():CellInfo
		{
			return m_LineCells[m_LineCells.length - 1];
		}
	}
}