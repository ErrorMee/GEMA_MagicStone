package FightModule.model.func
{
	import FightModule.model.CellInfo;
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;
	import FightModule.model.GridUtil;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridModelLineFunc
	{
		public static function line(gridModel:GridModel,x:int,y:int):void
		{
			var cellInfo:CellInfo = gridModel.getCell(x,y);
			if(cellInfo && cellInfo != gridModel.m_LastCell && cellInfo.link)
			{
				if(gridModel.m_LineCells.length)
				{
					if(gridModel.m_LineCells.indexOf(cellInfo) == -1)
					{
						if(GridUtil.isAround(gridModel.getLineEnd(),cellInfo))
						{
							if(gridModel.getLineEnd().m_Type == cellInfo.m_Type)
							{
								gridModel.m_LineCells.push(cellInfo);
								gridModel.publicDispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
							}
						}
					}
					else
					{
						if((!gridModel.m_LineCells.indexOf(cellInfo) && gridModel.m_LineCells.length == 2) || 
							gridModel.m_LineCells.indexOf(cellInfo) == (gridModel.m_LineCells.length - 2))
						{
							gridModel.m_LineCells.splice(gridModel.m_LineCells.length - 1,1);
							gridModel.publicDispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
						}
					}
					
				}else{
					gridModel.m_LineCells.push(cellInfo);
					gridModel.publicDispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
				}
				gridModel.m_LastCell = cellInfo;
			}
		}
	}
}