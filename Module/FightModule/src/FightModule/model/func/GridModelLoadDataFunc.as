package FightModule.model.func
{
	import flash.utils.ByteArray;
	
	import FightModule.model.CellInfo;
	import FightModule.model.GridModel;

	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridModelLoadDataFunc
	{
		public static function loadData(gridModel:GridModel,data:ByteArray):void
		{
			if(null == data) return;
			data.position = 0;
			
			gridModel.m_ID = data.readShort();
			var xNum:int = data.readShort();
			var yNum:int = data.readShort();
			
			gridModel.m_Cells = new Vector.<CellInfo>;
			for(var y:int = 0; y<yNum; y++)
			{
				for(var x:int = 0; x<xNum; x++)
				{
					var cellInfo:CellInfo = new CellInfo;
					cellInfo.m_XNum = x;
					cellInfo.m_YNum = y;
					
					cellInfo.m_Type = data.readByte();
					gridModel.m_Cells.push(cellInfo);
				}
			}
		}
	}
}