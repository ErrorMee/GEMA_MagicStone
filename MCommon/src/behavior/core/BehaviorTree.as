package behavior.core
{
	/******************************************************
	 * 行为树
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class BehaviorTree extends Behavior
	{
		protected var m_BehaviorList:Vector.<Behavior>;
		
		public function BehaviorTree()
		{
			m_BehaviorList = new Vector.<Behavior>;
		}
		
		public function addBehavior(b:Behavior):void
		{
			if(null == b) return;
			b.addEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
			m_BehaviorList.push(b);
		}
		
		private function onBehaviorEnd(e:BehaviorEvent):void
		{
			if(e == null)
			{
				return ;
			}
			
			var b:Behavior = e.currentTarget as Behavior;
			if(b)
			{
				b.removeEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
				b.onDispose();
				removeBehavior(b);
			}
			
			if(isEnd())
				onEnd();
			else
				onNext();
		}
		
		private function removeBehavior(b:Behavior):void
		{
			if(null == b) return;
			var index:int = m_BehaviorList.indexOf(b);
			if(-1 != index)
			{
				m_BehaviorList.splice(index,1);
			}
		}
		
		private function isEnd():Boolean
		{
			var len:int = m_BehaviorList.length;
			if(len <= 0) return true;
			return false;
		}
		
		protected function onNext():void
		{
		}
		
		override public function onExecute():void
		{
			if(isEnd()) 
			{
				onEnd();
			}
			else
			{
				onRun();
			}
		}
		
		protected function onRun():void
		{
		}
		
		override public function onDispose():void
		{
			while(m_BehaviorList.length)
			{
				var b:Behavior = m_BehaviorList.pop();
				b.removeEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
				b.onDispose();
			}	
		}
	}
}