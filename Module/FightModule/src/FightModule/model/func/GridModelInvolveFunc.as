package FightModule.model.func
{
	import FightModule.model.CellInfo;
	import FightModule.model.GridModel;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridModelInvolveFunc
	{
		public static function InvolveCells(gridModel:GridModel,cell:CellInfo):Vector.<CellInfo>
		{
			var cells:Vector.<CellInfo> = new Vector.<CellInfo>;
			
			if(cell.involve_atk)
			{
				pushCell(cell.m_XNum - 1,cell.m_YNum,gridModel,cells,cell.involve_atk);
				pushCell(cell.m_XNum + 1,cell.m_YNum,gridModel,cells,cell.involve_atk);
				pushCell(cell.m_XNum,cell.m_YNum - 1,gridModel,cells,cell.involve_atk);
				pushCell(cell.m_XNum,cell.m_YNum + 1,gridModel,cells,cell.involve_atk);
			}
			
			return cells;
		}
		
		private static function pushCell(x:int, y:int, gridModel:GridModel, cells:Vector.<CellInfo>,involve_atk:int):void
		{
			var pushCell:CellInfo = gridModel.getCell(x,y);
			if(pushCell)
			{
				if(pushCell.involve)
				{
					pushCell.involve_def -= involve_atk;
					cells.push(pushCell);
				}
			}
		}
	}
}