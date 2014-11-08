package FightModule.behaviors
{
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
	public class ScaleBehavior extends Behavior
	{
		private var m_CellItem:CellItem;
		
		private var m_ToScale:Number;
		
		private var m_Time:Number;
		
		public function ScaleBehavior(cellItem:CellItem,toScale:Number,time:Number = 0.2)
		{
			super();
			m_CellItem = cellItem;
			m_ToScale = toScale;
			m_Time = time;
		}
		
		override public function onExecute():void
		{
			if(m_CellItem)
			{
				var tweenScale:Tween = new Tween(m_CellItem,m_Time,Transitions.EASE_IN);
				tweenScale.scaleTo(m_ToScale);
				tweenScale.onComplete = function():void
				{
					m_CellItem = null;
					onEnd();
				}
				Starling.juggler.add(tweenScale);
			}else{
				m_CellItem = null;
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
		}
	}
}

