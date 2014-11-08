package tick
{
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class TickManager
	{
		public function TickManager(enforcer:SingletonEnforcer)
		{
			if(!enforcer) throw new Error("singletonEnforcer");
			enforcer = null;
			m_TickList = new Vector.<Tick>;
		}
		private static var g_Instance:TickManager;
		public static function GetInstance():TickManager
		{
			return g_Instance || (g_Instance = new TickManager(new SingletonEnforcer()));
		}
		
		
		private var m_TickList:Vector.<Tick> = new Vector.<Tick>;
		private var m_TickDispatcher:EventDispatcher;
		private var m_LastTime:uint;
		
		public function setup(dispatcher:EventDispatcher):void
		{
			if(m_TickDispatcher)
			{
				m_TickDispatcher.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
			m_TickDispatcher = dispatcher;
			if(m_TickDispatcher) 
			{
				m_TickDispatcher.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
		}
		
		public function addTick(tick:Tick):void
		{
			if(null == m_TickList) return;
			if(m_TickList.indexOf(tick) == -1)
				m_TickList.push(tick);
		}
		
		private function onEnterFrame(evt:Event):void
		{
			if(!m_TickList.length)
			{
				return;
			}
			
			var nowTime:uint = (new Date).time;
			var timeElapsed:uint = nowTime - m_LastTime;
			
			m_LastTime = nowTime; 
			var ticker:Tick;
			var i:int = m_TickList.length - 1;
			for(; i >= 0; i--) 
			{
				ticker = m_TickList[i];
				if(ticker && !ticker.isEnd() && !ticker.isStop())
				{
					ticker.onTick(timeElapsed);
				}
				else 
				{
					m_TickList.splice(i,1);
				}
			}
		}
		
	}
}

class SingletonEnforcer 
{
}