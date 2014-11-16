package FightModule
{
	import FightModule.model.GridModel;
	import FightModule.panel.GridInitMediator;
	import FightModule.panel.GridPlayMediator;
	import FightModule.panel.GridTouchMediator;
	import FightModule.panel.LineMediator;
	
	import gema.Module.core.ModuleMediator;
	
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	public class FightMediator extends ModuleMediator
	{
		private var m_GridModel:GridModel;
		
		public function FightMediator()
		{
			super();
		}
		
		private function get view():FightView
		{
			return getViewComponent() as FightView;
		}
		
		override protected function initMediator():void
		{
			registerComponentMediator(view.m_GridPanel,GridInitMediator);
			registerComponentMediator(view.m_GridPanel,GridTouchMediator);
			registerComponentMediator(view.m_GridPanel,GridPlayMediator);
			
			registerComponentMediator(view.m_LinePanel,LineMediator);
		}
		
		override protected function initView():void
		{
		}
		
		override protected function initEvent():void
		{
		}
	}
}