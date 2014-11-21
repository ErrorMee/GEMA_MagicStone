package FightModule.model.func
{
	import flash.utils.ByteArray;
	
	import FightModule.model.CellInfo;
	import FightModule.model.GridModel;
	import FightModule.model.WallInfo;

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
			gridModel.m_Cells = new Vector.<CellInfo>;
			
			var xNum:int = data.readShort();
			var yNum:int = data.readShort();
			
			var y:int = 0;
			var x:int = 0;
			for(y = 0; y<yNum; y++)
			{
				for(x = 0; x<xNum; x++)
				{
					var cellInfo:CellInfo = new CellInfo;
					cellInfo.m_XNum = x;
					cellInfo.m_YNum = y;
					
					cellInfo.m_Type = data.readByte();
					gridModel.m_Cells.push(cellInfo);
				}
			}
			
			var wallInfo:WallInfo;
			gridModel.m_Walls = new Vector.<WallInfo>;
			xNum = xNum*2 - 1;
			for(y = 0; y<yNum; y++)
			{
				for(x = 0; x<xNum; x++)
				{
					wallInfo = new WallInfo;
					wallInfo.m_Type = data.readByte();
					gridModel.m_Walls.push(wallInfo);
				}
			}
		}
	}
}