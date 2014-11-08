package FightModule.behaviors
{
	import FightModule.element.CellItem;
	
	import behavior.core.Behavior;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class CellAddBehavior extends Behavior
	{
		private var m_CellItem:CellItem;
		
		private var m_CellLayer:Sprite;
		
		private var m_Time:Number;
		
		public function CellAddBehavior(cellItem:CellItem,layer:Sprite,time:Number = 0.2)
		{
			super();
			m_CellItem = cellItem;
			m_CellLayer = layer;
			m_Time = time;
			
			m_CellLayer.addChild(m_CellItem);
			m_CellItem.visible = false;
		}
		
		override public function onExecute():void
		{
			if(m_CellItem)
			{
				m_CellItem.visible = true;
				m_CellItem = null;
				m_CellLayer = null;
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
			m_CellLayer = null;
		}
	}
}

