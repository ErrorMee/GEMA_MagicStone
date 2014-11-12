package FightModule.behaviors
{
	import FightModule.element.CellItem;
	
	import gema.behavior.core.Behavior;
	
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
	public class AlphaBehavior extends Behavior
	{
		private var m_CellItem:CellItem;
		
		private var m_ToAlpha:Number;
		
		private var m_Time:Number;
		
		public function AlphaBehavior(cellItem:CellItem,toAlpha:Number,time:Number = 0.2)
		{
			super();
			m_CellItem = cellItem;
			m_ToAlpha = toAlpha;
			m_Time = time;
		}
		
		override public function onExecute():void
		{
			if(m_CellItem)
			{
				var tweenAlpha:Tween = new Tween(m_CellItem,m_Time,Transitions.EASE_IN);
				tweenAlpha.fadeTo(m_ToAlpha);
				tweenAlpha.onComplete = function():void
				{
					m_CellItem = null;
					onEnd();
				}
				Starling.juggler.add(tweenAlpha);
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