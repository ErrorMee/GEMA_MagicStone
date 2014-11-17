package FightModule.model.func
{
	import FightModule.model.CellInfo;
	import FightModule.model.GridModel;
	
	import gema.structure.PPoint;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridModelFillFunc
	{
		public static function fill(gridModel:GridModel):void
		{
			var leaks:Array = [1,4,7];//todo 暂时开放 1 4 7 号口
			var fillFlag:Boolean = false;
			var i:int = 0;
			for(;i<leaks.length;i++)
			{
				var leahX:int = leaks[i];
				
				var cell:CellInfo = gridModel.getCell(leahX,0);
				if(cell == null)
				{
					fillFlag = true;
					cell = new CellInfo;
					//					cell.m_Type = 2;
					//					cell.m_Type = int(Math.random()*5) + 1;
					cell.m_Type = int(Math.random()*9) + 1;
					cell.m_XNum = leahX;
					cell.m_YNum = 0;
					fillOne(gridModel,cell);
				}
			}
			if(fillFlag)
			{
				fill(gridModel);
			}
		}
		
		/**
		 * 添加一个 并让其稳定
		 */
		private static function fillOne(gridModel:GridModel,cell:CellInfo):void
		{
			gridModel.m_Cells.push(cell);
			
			var pp:PPoint = new PPoint;
			pp.m_PreX = cell.m_XNum;
			pp.m_PreY = (cell.m_YNum - 1);
			gridModel.i_AnimationModel.addMove([pp]);
			
			GridModelFallFunc.fall(gridModel,[]);
			GridModelStableFunc.stable(gridModel);
			
			pp.m_ToX = cell.m_XNum;
			pp.m_ToY = cell.m_YNum;
		}
	}
}