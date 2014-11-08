package FightModule.behaviors
{
	import flash.geom.Point;
	
	import FightModule.element.CellItem;
	
	import behavior.core.Behavior;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class MoveBehavior extends Behavior
	{
		private var m_CellItem:CellItem;
		
		private var m_EndPoint:Point;
		
		private var m_Time:Number;
		
		public function MoveBehavior(cellItem:CellItem,endPoint:Point,time:Number = 0.2)
		{
			super();
			m_CellItem = cellItem;
			m_EndPoint = endPoint;
			m_Time = time;
		}
		
		override public function onExecute():void
		{
			if(m_CellItem)
			{
				if(m_CellItem.parent)
				{
					m_CellItem.parent.addChild(m_CellItem);
				}
				
				var tweenMove:Tween = new Tween(m_CellItem,m_Time,Transitions.LINEAR);
				tweenMove.moveTo(m_EndPoint.x,m_EndPoint.y);
				tweenMove.onComplete = function():void
				{
					m_CellItem = null;
					m_EndPoint = null;
					onEnd();
				}
				Starling.juggler.add(tweenMove);
			}else{
				m_CellItem = null;
				m_EndPoint = null;
				onEnd();
			}
		}
		
		override public function onDispose():void
		{
			super.onDispose();
			if(m_CellItem)
			{
				m_CellItem = null;
			}
			m_EndPoint = null;
		}
	}
}