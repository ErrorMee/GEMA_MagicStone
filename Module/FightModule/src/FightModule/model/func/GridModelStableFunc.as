package FightModule.model.func
{
	import FightModule.model.CellInfo;
	import FightModule.model.FightConst;
	import FightModule.model.GridModel;
	
	import gema.structure.PPoint;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridModelStableFunc
	{
		public static function stable(gridModel:GridModel):void
		{
			var y:int = FightConst.X_NUM - 1;
			for(;y>=0;y--)
			{
				y = stableYLine(gridModel,y);
			}
		}
		
		private static function stableYLine(gridModel:GridModel,y:int):int
		{
			var cells:Vector.<CellInfo> = gridModel.getCellsByYNum(y);
			var hasChange:Boolean = false;
			var i:int = 0;
			for(;i<cells.length;i++)
			{
				var cellInfo:CellInfo = cells[i];
				var stableType:int = getStable(gridModel,cellInfo);
				
				var ups:Vector.<CellInfo> = new Vector.<CellInfo>;
				if(stableType != FightConst.STABLE)
				{
					hasChange = true;
					ups = gridModel.getCellsByXNum(cellInfo.m_XNum,0,cellInfo.m_YNum);
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
					gridModel.i_AnimationModel.addMove(moveArr);
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
					gridModel.i_AnimationModel.addMove(moveArr);
					cellInfo.m_XNum ++;
					cellInfo.m_YNum ++;
				}
				
				var upsi:int = ups.length - 1;
				moveArr = [];
				for(;upsi >= 0;upsi--)
				{
					var cell:CellInfo = ups[upsi];
					if(cell.stable)
					{
						break;
					}
					pp = new PPoint;
					pp.m_PreX = cell.m_XNum;
					pp.m_PreY = cell.m_YNum;
					pp.m_ToX = (cell.m_XNum);
					pp.m_ToY = (cell.m_YNum + 1);
					moveArr.push(pp);
					cell.m_YNum ++;
				}
				gridModel.i_AnimationModel.addMove(moveArr);
			}
			
			if(hasChange)
			{
				stableYLine(gridModel,y + 1);
			}
			return y;
		}
		
		private static function getStable(gridModel:GridModel,cellInfo:CellInfo):int
		{
			var leftStable:Boolean = false;
			var rightStable:Boolean = false;
			
			if(cellInfo.stable)
			{
				return FightConst.STABLE;
			}
			
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
				var leftCell:CellInfo = gridModel.getCell(cellInfo.m_XNum - 1,cellInfo.m_YNum + 1);
				if(leftCell)
				{
					leftStable = true;
				}
			}
			
			if(!rightStable)
			{
				var rightCell:CellInfo = gridModel.getCell(cellInfo.m_XNum + 1,cellInfo.m_YNum + 1);
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
			
			return FightConst.STABLE;
		}
	}
}