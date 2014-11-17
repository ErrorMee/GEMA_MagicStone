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
	public class GridModelFallFunc
	{
		public static function fall(gridModel:GridModel,moveArr:Array):void
		{
			var x:int;
			for(x = 0;x<FightConst.X_NUM;x++)
			{
				var cells:Vector.<CellInfo> = gridModel.getCellsByXNum(x);
				
				var yNum:int = FightConst.X_NUM;
				var i:int = (cells.length - 1);
				for(;i >= 0;i--)
				{
					if(cells.length>i)
					{
						yNum --;
						var cellInfo:CellInfo = cells[i];
						if(cellInfo.stable)
						{
							yNum = cellInfo.m_YNum;
							continue;	
						}
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
			gridModel.i_AnimationModel.addMove(moveArr);
		}
	}
}