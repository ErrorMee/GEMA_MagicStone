package FightModule.model2048
{
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	import util.PosUtil;
	import FightModule.model.FightConst;

	public class Grid2048Model extends EventDispatcher
	{
		private var m_Grid:Array = [];
		
		public static function getInstance():Grid2048Model
		{
			return _instance;
		}
		private static  var _instance:Grid2048Model = new Grid2048Model();
		public function Grid2048Model()
		{
			if(_instance)
			{
				throw new Error("只能用getInstance()来获取实例");
			}
		}
		
		public function initGrid():void
		{
			m_Grid = [];
			for(var i:int = 0;i<FightConst.X_NUM*FightConst.X_NUM;i++)
			{
				var grid:Grid2048Info = new Grid2048Info();
				grid.m_Pos = i;
				grid.m_Value = Math.random() > 0.5 ? 1:2;
				grid.m_Type = Math.random() > 0.5 ? Grid2048TypeEnum.TYPE_ATK:Grid2048TypeEnum.TYPE_LIFE;
				m_Grid.push(grid);
			}
			
			notice(Event.CHANGE);
		}
		
		public function getGrid():Array
		{
			return m_Grid;
		}
		
		public function moveGrid(dir:int):void
		{
			switch(dir)
			{
				case PosUtil.DIR_LEFT:
				case PosUtil.DIR_RIGHT:
				case PosUtil.DIR_TOP:
				case PosUtil.DIR_BOT:
					combin(dir);
					swap(dir);
//					addGrid(dir);
					break;
			}
			notice(Event.CHANGE);
		}
		
		private function combin(dir:int):void
		{
			var i:int;
			for(i = 0;i<FightConst.X_NUM;i++)
			{
				var tempArr:Array = [];
				if(dir == PosUtil.DIR_RIGHT || dir == PosUtil.DIR_LEFT)
				{
					tempArr = m_Grid.slice(i*FightConst.X_NUM,(i+1)*FightConst.X_NUM);
				}else{
					var n:int = 0
					for(;n<FightConst.X_NUM;n++)
					{
						tempArr.push(m_Grid[i + FightConst.X_NUM*n]);
					}
				}
				
				var j:int;
				var validArr:Array = [];
				for(j = 0;j < tempArr.length;j++)
				{
					var tempInfo:Grid2048Info = tempArr[j];
					if(tempInfo.m_Value)
					{
						if(dir == PosUtil.DIR_RIGHT || dir == PosUtil.DIR_BOT)
						{
							validArr.unshift(tempInfo);
						}else{
							validArr.push(tempInfo);
						}
					}
				}
				
				for(j = 0;j < validArr.length;j++)
				{
					var validInfo:Grid2048Info = validArr[j];
					if(validArr.length > (j+1))
					{
						var nextInfo:Grid2048Info = validArr[j+1];
						if(nextInfo.m_Value && nextInfo.m_Value == validInfo.m_Value && nextInfo.m_Type == validInfo.m_Type)
						{
							nextInfo.m_Value = ++nextInfo.m_Value;
							validInfo.m_Value = 0;
							j++;
						}
					}
				}
			}
		}
		
		private function swap(dir:int):void
		{
			var i:int;
			for(i = 0;i<FightConst.X_NUM;i++)
			{
				var tempArr:Array = [];
				if(dir == PosUtil.DIR_RIGHT || dir == PosUtil.DIR_LEFT)
				{
					tempArr = m_Grid.slice(i*FightConst.X_NUM,(i+1)*FightConst.X_NUM);
				}else{
					var n:int = 0
					for(;n<FightConst.X_NUM;n++)
					{
						tempArr.push(m_Grid[i + FightConst.X_NUM*n]);
					}
				}
				
				var j:int;
				var validArr:Array = [];
				for(j = 0;j < tempArr.length;j++)
				{
					var tempInfo:Grid2048Info = tempArr[j];
					if(tempInfo.m_Value)
					{
						if(dir == PosUtil.DIR_RIGHT || dir == PosUtil.DIR_BOT)
						{
							validArr.unshift(tempInfo.copy());
						}else{
							validArr.push(tempInfo.copy());
						}
					}
					tempInfo.m_Value = 0;
				}
				
				for(j = 0;j < tempArr.length;j++)
				{
					if(validArr.length>j)
					{
						var index:int = j;
						if(dir == PosUtil.DIR_RIGHT || dir == PosUtil.DIR_BOT)
						{
							index = Math.abs(tempArr.length - j - 1);
						}
						tempInfo = tempArr[index];
						var validInfo:Grid2048Info = validArr[j];
						tempInfo.m_Value = validInfo.m_Value;
						tempInfo.m_Type = validInfo.m_Type;
					}
				}
			}
		}
		
		private function addGrid(dir:int):void
		{
			var tempArr:Array = [];
			var i:int;
			var len:int = m_Grid.length;
			for(i = 0;i<len;i++)
			{
				var tempInfo:Grid2048Info = m_Grid[i];
				if(!tempInfo.m_Value)
				{
					tempArr.push(tempInfo);
				}
			}
			if(tempArr.length)
			{
				var validInfo:Grid2048Info = tempArr[int(tempArr.length*Math.random())];
				validInfo.m_Value = Math.random() > 0.5 ? 1:2;
				validInfo.m_Type = Math.random() > 0.5 ? Grid2048TypeEnum.TYPE_ATK:Grid2048TypeEnum.TYPE_LIFE;
			}else{
				notice(Event.COMPLETE);
			}
		}
		
		public function notice(type:String):void
		{
			dispatchEvent(new Event(type));
		}
		
	}
}