package tick
{
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class Tick
	{
		private var m_Timer:int = 0;
		private var m_StopTime:int = 0;
		private var m_AccumulativeTime:int = 0;
		private var m_StopFlag:Boolean = true;
		private var m_EndFlag:Boolean = false;
		private var m_CallBack:Function;
		protected var m_Delay:uint;
		
		public function Tick(pDelay:uint = 17,stopTime:uint = 0)
		{
			m_Delay = pDelay;
			m_StopTime = stopTime;
			TickManager.GetInstance().addTick(this);
		}
		
		public function setCallBack(callBack:Function):void 
		{
			m_CallBack = callBack;
		}
		
		protected function update():void 
		{
			if(null != m_CallBack) m_CallBack();
		}
		
		public function onTick(timeElapsed:int):void
		{
			if(isEnd()) return;
			if(isStop()) return;
			if(m_StopTime > 0)
			{
				m_AccumulativeTime += timeElapsed;
				if(m_AccumulativeTime > m_StopTime)
				{
					stop();
					return;	
				}
			}
			if(m_Delay > 0) 
			{
				m_Timer += timeElapsed;
				while(m_Timer >= m_Delay)
				{
					update();
					m_Timer -= m_Delay;
					if(isEnd()) break;
					if(isStop()) break;
				}
			}
		}
		
		public function start():void
		{
			m_StopFlag = false;
		}
		
		public function reStart():void
		{
			m_StopFlag = false;
			m_Timer = 0;
			m_AccumulativeTime = 0;
		}
		
		public function stop():void
		{
			m_StopFlag = true;
		}
		
		public function isStop():Boolean
		{
			return m_StopFlag;
		}
		
		public function isEnd():Boolean
		{
			return m_EndFlag;
		}
		
		public function onClear():void
		{
			stop();
			m_CallBack = null;
			m_EndFlag = true;
		}
		
		public function onDispose():void
		{
			onClear();
		}
	}
}