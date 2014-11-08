package behavior.core
{
	/******************************************************
	 * 循环行为
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class LoopBehavior extends Behavior
	{
		private var m_LoopCount:int;
		private var m_CrtLoopIndex:int;
		private var m_CrtBehaviorIndex:int;
		
		private var m_BehaviorList:Vector.<Behavior>;
		
		public function LoopBehavior(count:int = 1)
		{
			super();
			m_LoopCount = m_CrtLoopIndex = (++count);
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
			if(null == e) return;
			
			var lastIndex:int = m_CrtBehaviorIndex;
			
			if(m_CrtBehaviorIndex == m_BehaviorList.length - 1 && m_CrtLoopIndex > 1)
			{
				m_CrtBehaviorIndex = 0;
				m_CrtLoopIndex --;
			}else
			{
				m_CrtBehaviorIndex ++;
			}
			
			if(isEnd(lastIndex))
			{
				onEnd();
			}
			else
			{
				onRun();
			}
		}
		
		private function isEnd(lastIndex:int):Boolean
		{
			if(lastIndex == m_BehaviorList.length - 1 && m_CrtLoopIndex <= 1)
			{
				return true;
			}
			return false;
		}
		
		protected function onRun():void
		{
			var behavior:Behavior = m_BehaviorList[m_CrtBehaviorIndex];
			behavior.onExecute();
		}
		
		override public function onExecute():void
		{
			m_CrtBehaviorIndex = 0;
			m_CrtLoopIndex = m_LoopCount;
			
			if(isEnd(-1)) 
			{
				onEnd();
			}
			else
			{
				onRun();
			}
		}
		
		override public function onDispose():void
		{
			while(m_BehaviorList.length)
			{
				var behavior:Behavior = m_BehaviorList.pop();
				behavior.removeEventListener(BehaviorEvent.BEHAVIOR_END,onBehaviorEnd);
				behavior.onDispose();
			}	
		}
	}
}