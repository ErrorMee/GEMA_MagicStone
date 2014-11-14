package FightModule.model
{
	import flash.utils.ByteArray;
	
	import gema.structure.ModelActor;
	import gema.structure.PPoint;
	
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
		
		public var m_ID:int;
		
		private var m_Cells:Vector.<CellInfo> = new Vector.<CellInfo>;
		
		private var m_LineCells:Vector.<CellInfo> = new Vector.<CellInfo>;
		
		public function getCells():Vector.<CellInfo>
		{
			return m_Cells;
		}
		
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
		
		public function loadData(data:ByteArray):void
		{
			if(null == data) return;
			data.position = 0;
			
			m_ID = data.readShort();
			var xNum:int = data.readShort();
			var yNum:int = data.readShort();
			
			m_Cells = new Vector.<CellInfo>;
			for(var y:int = 0; y<yNum; y++)
			{
				for(var x:int = 0; x<xNum; x++)
				{
					var cellInfo:CellInfo = new CellInfo;
					cellInfo.m_XNum = x;
					cellInfo.m_YNum = y;
					
					cellInfo.m_Type = data.readByte();
//					cellInfo.m_Type = 1;//todo
					m_Cells.push(cellInfo);
				}
			}
		}
		
		private var m_LastCell:CellInfo;
		public function line(x:int,y:int):void
		{
			var cellInfo:CellInfo = getCell(x,y);
			if(cellInfo && cellInfo != m_LastCell)
			{
				if(m_LineCells.length)
				{
					if(m_LineCells.indexOf(cellInfo) == -1)
					{
						if(GridUtil.isAround(getLineEnd(),cellInfo))
						{
							if(getLineEnd().m_Type == cellInfo.m_Type)
							{
								m_LineCells.push(cellInfo);
								dispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
							}
						}
					}
					else
					{
						if((!m_LineCells.indexOf(cellInfo) && m_LineCells.length == 2) || m_LineCells.indexOf(cellInfo) == (m_LineCells.length - 2))
						{
							m_LineCells.splice(m_LineCells.length - 1,1);
							dispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
						}
					}
					
				}else{
					m_LineCells.push(cellInfo);
					dispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
				}
				m_LastCell = cellInfo;
			}
		}
		
		public function clearLine():void
		{
			if(m_LineCells && m_LineCells.length>2)
			{
				var i:int = 0;
				var cell:CellInfo;
				for(;i<m_LineCells.length;i++)
				{
					cell = m_LineCells[i];
					deleteCell(cell);
					i_AnimationModel.line(cell);
				}
				fall([]);
				stable();
				fill();
				dispatch(new GridEvent(GridEvent.GRID_CHANGE));
			}
			m_LineCells = new Vector.<CellInfo>;
			m_LastCell = null;
			dispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
		}
		
		private function fall(moveArr:Array):void
		{
			var x:int;
			for(x = 0;x<FightConst.X_NUM;x++)
			{
				var cells:Vector.<CellInfo> = getCellsByXNum(x);
				
				var yNum:int = FightConst.X_NUM;
				var i:int = (cells.length - 1);
				for(;i >= 0;i--)
				{
					if(cells.length>i)
					{
						yNum --;
						var cellInfo:CellInfo = cells[i];
						
						var pp:PPoint = new PPoint;
						pp.m_PreX = cellInfo.m_XNum;
						pp.m_PreY = cellInfo.m_YNum;
						pp.m_ToX = cellInfo.m_XNum;
						pp.m_ToY = yNum;
						moveArr.push(pp);
						cellInfo.m_YNum = yNum;
					}
				}
			}
			i_AnimationModel.addMove(moveArr);
		}
		
		private function stable():void
		{
			var y:int = FightConst.X_NUM - 1;
			for(;y>=0;y--)
			{
				y = stableYLine(y);
			}
		}
		
		private function stableYLine(y:int):int
		{
			var cells:Vector.<CellInfo> = getCellsByYNum(y);
			var hasChange:Boolean = false;
			var i:int = 0;
			for(;i<cells.length;i++)
			{
				var cellInfo:CellInfo = cells[i];
				var stableType:int = getStable(cellInfo);
				
				var ups:Vector.<CellInfo> = new Vector.<CellInfo>;
				if(stableType != FightConst.NO_UNSTABLE)
				{
					hasChange = true;
					ups = getCellsByXNum(cellInfo.m_XNum,0,cellInfo.m_YNum);
				}
				var moveArr:Array = [];
				if(stableType == FightConst.LEFT_UNSTABLE)
				{
					var pp:PPoint = new PPoint;
					pp.m_PreX = cellInfo.m_XNum;
					pp.m_PreY = cellInfo.m_YNum;
					pp.m_ToX = (cellInfo.m_XNum - 1);
					pp.m_ToY = (cellInfo.m_YNum + 1);
					moveArr.push(pp);
					i_AnimationModel.addMove(moveArr);
					cellInfo.m_XNum --;
					cellInfo.m_YNum ++;
				}
				
				moveArr = [];
				if(stableType == FightConst.RIGHT_UNSTABLE)
				{
					pp = new PPoint;
					pp.m_PreX = cellInfo.m_XNum;
					pp.m_PreY = cellInfo.m_YNum;
					pp.m_ToX = (cellInfo.m_XNum + 1);
					pp.m_ToY = (cellInfo.m_YNum + 1);
					moveArr.push(pp);
					i_AnimationModel.addMove(moveArr);
					cellInfo.m_XNum ++;
					cellInfo.m_YNum ++;
				}
				
				var upsi:int = ups.length - 1;
				moveArr = [];
				for(;upsi >= 0;upsi--)
				{
					var cell:CellInfo = ups[upsi];
					pp = new PPoint;
					pp.m_PreX = cell.m_XNum;
					pp.m_PreY = cell.m_YNum;
					pp.m_ToX = (cell.m_XNum);
					pp.m_ToY = (cell.m_YNum + 1);
					moveArr.push(pp);
					cell.m_YNum ++;
				}
				i_AnimationModel.addMove(moveArr);
			}
			
			if(hasChange)
			{
				stableYLine(y + 1);
			}
			return y;
		}
		
		private function getCellsByXNum(x:int,minY:int = 0,maxY:int = FightConst.X_NUM):Vector.<CellInfo>
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
		
		private function getCellsByYNum(y:int,minX:int = 0,maxX:int = FightConst.X_NUM):Vector.<CellInfo>
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
		
		private function getStable(cellInfo:CellInfo):int
		{
			var leftStable:Boolean = false;
			var rightStable:Boolean = false;
			
			if(!cellInfo.m_XNum)
			{
				leftStable = true;
			}
			
			if(cellInfo.m_XNum == (FightConst.X_NUM - 1))
			{
				rightStable = true;
			}
			
			if(cellInfo.m_YNum == (FightConst.X_NUM - 1))
			{
				leftStable = true;
				rightStable = true;
			}
			
			if(!leftStable)
			{
				var leftCell:CellInfo = getCell(cellInfo.m_XNum - 1,cellInfo.m_YNum + 1);
				if(leftCell)
				{
					leftStable = true;
				}
			}
			
			if(!rightStable)
			{
				var rightCell:CellInfo = getCell(cellInfo.m_XNum + 1,cellInfo.m_YNum + 1);
				if(rightCell)
				{
					rightStable = true;
				}
			}
			
			if(!leftStable)
			{
				return FightConst.LEFT_UNSTABLE;
			}
			
			if(!rightStable)
			{
				return FightConst.RIGHT_UNSTABLE;
			}
			
			return FightConst.NO_UNSTABLE;
		}
		
		private function fill():void
		{
			var leaks:Array = [1,4,7];//todo 暂时开放 1 4 7 号口
			var fillFlag:Boolean = false;
			var i:int = 0;
			for(;i<leaks.length;i++)
			{
				var leahX:int = leaks[i];
				
				var cell:CellInfo = getCell(leahX,0);
				if(cell == null)
				{
					fillFlag = true;
					cell = new CellInfo;
//					cell.m_Type = 1;//todo cell.m_Type =  Math.random()*6;
					cell.m_Type =  Math.random()*6;
					cell.m_XNum = leahX;
					cell.m_YNum = 0;
					fillOne(cell);
				}
			}
			if(fillFlag)
			{
				fill();
			}
		}
		
		/**
		 * 添加一个 并让其稳定
		 */
		private function fillOne(cell:CellInfo):void
		{
			m_Cells.push(cell);
			
			var pp:PPoint = new PPoint;
			pp.m_PreX = cell.m_XNum;
			pp.m_PreY = (cell.m_YNum - 1);
			i_AnimationModel.addMove([pp]);
			
			fall([]);
			stable();
			
			pp.m_ToX = cell.m_XNum;
			pp.m_ToY = cell.m_YNum;
		}
		
		private function getLineEnd():CellInfo
		{
			return m_LineCells[m_LineCells.length - 1];
		}
		
		public function getLineCells():Vector.<CellInfo>
		{
			return m_LineCells;
		}
	}
}