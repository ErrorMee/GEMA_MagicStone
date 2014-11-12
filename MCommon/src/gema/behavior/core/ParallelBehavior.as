package gema.behavior.core
{
	/******************************************************
	 * 并行行为
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class ParallelBehavior extends BehaviorTree
	{
		public function ParallelBehavior()
		{
			super();
		}
		
		override protected function onRun():void
		{
			var len:int = m_BehaviorList.length;
			for(var i:int = len - 1; i >= 0; i--)
			{
				var b:Behavior = m_BehaviorList[i];
				b.onExecute();				
			}
		}
	}
}