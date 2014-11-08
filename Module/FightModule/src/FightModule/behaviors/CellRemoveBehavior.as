package FightModule.behaviors
{
	import flash.geom.Point;
	
	import FightModule.element.CellItem;
	
	import behavior.core.ParallelBehavior;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class CellRemoveBehavior extends ParallelBehavior
	{
		private var m_CellItem:CellItem;
		
		public function CellRemoveBehavior(cellItem:CellItem,endPoint:Point,time:Number = 0.2)
		{
			super();
			
			m_CellItem = cellItem;
			
			var moveBehavior:MoveBehavior = new MoveBehavior(cellItem,endPoint,time);
			var alphaBehavior:AlphaBehavior = new AlphaBehavior(cellItem,0.5,time);
			var scaleBehavior:ScaleBehavior = new ScaleBehavior(cellItem,0.2,time);
			
			addBehavior(moveBehavior);
			addBehavior(alphaBehavior);
			addBehavior(scaleBehavior);
		}
		
		override public function onExecute():void
		{
			super.onExecute();
		}
		
		override protected function onEnd():void
		{
			if(m_CellItem)
			{
				m_CellItem.removeFromParent(true);
				m_CellItem = null;
			}
			super.onEnd();
		}
		
		override public function onDispose():void
		{
			super.onDispose();
			if(m_CellItem)
			{
				m_CellItem.removeFromParent(true);
				m_CellItem = null;
			}
		}
	}
}