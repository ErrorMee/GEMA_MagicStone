package FightModule.model.func
{
	import FightModule.model.CellInfo;
	import FightModule.model.GridEvent;
	import FightModule.model.GridModel;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridModelClearLineFunc
	{
		public static function clearLine(gridModel:GridModel):void
		{
			if(gridModel.m_LineCells && gridModel.m_LineCells.length>2)
			{
				var i:int = 0;
				var j:int = 0;
				var cell:CellInfo;
				for(;i<gridModel.m_LineCells.length;i++)
				{
					cell = gridModel.m_LineCells[i];
					var involveCells:Vector.<CellInfo> = GridModelInvolveFunc.InvolveCells(gridModel,cell);
					
					for(j = 0;j<involveCells.length;j++)
					{
						var involveCell:CellInfo = involveCells[j];
						if(involveCell.involve_def <= 0)
						{
							gridModel.deleteCell(involveCell);
							gridModel.i_AnimationModel.line(involveCell);
						}
					}
					
					gridModel.deleteCell(cell);
					gridModel.i_AnimationModel.line(cell);
				}
				GridModelFallFunc.fall(gridModel,[]);
				GridModelStableFunc.stable(gridModel);
				GridModelFillFunc.fill(gridModel);
				gridModel.publicDispatch(new GridEvent(GridEvent.GRID_CHANGE));
			}
			gridModel.m_LineCells = new Vector.<CellInfo>;
			gridModel.m_LastCell = null;
			gridModel.publicDispatch(new GridEvent(GridEvent.GRID_LINE_CHANGE));
		}
	}
}