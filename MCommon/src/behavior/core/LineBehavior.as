package behavior.core
{
	/******************************************************
	 * 线性行为
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class LineBehavior extends BehaviorTree
	{
		public function LineBehavior()
		{
			super();
		}
		
		override protected function onRun():void
		{
			var b:Behavior = m_BehaviorList[0];
			b.onExecute();
		}
		
		override protected function onNext():void
		{
			onRun();
		}
	}
}