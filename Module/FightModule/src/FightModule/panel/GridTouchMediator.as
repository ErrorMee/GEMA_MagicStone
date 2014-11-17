package FightModule.panel
{
	import flash.geom.Point;
	
	import FightModule.FightContext;
	import FightModule.model.FightConst;
	import FightModule.model.GridModel;
	import FightModule.model.func.GridModelClearLineFunc;
	import FightModule.model.func.GridModelLineFunc;
	
	import gema.Module.base.FlashEvent;
	import gema.Module.core.ModuleMediator;
	import gema.util.DisUtil;
	import gema.util.PosUtil;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class GridTouchMediator extends ModuleMediator
	{
		[Inject]
		public var i_GridModel:GridModel;
		
		public function GridTouchMediator()
		{
			super();
		}
		
		private function get view():GridPanel
		{
			return getViewComponent() as GridPanel;
		}
		
		override protected function initEvent():void
		{
			view.addEventListener(TouchEvent.TOUCH,onTouch);
			addContextListener(FightContext.EVENT_START_PLAY,onPlayStart);
			addContextListener(FightContext.EVENT_END_PLAY,onPalyEnd);
		}
		
		private function onPlayStart(e:FlashEvent):void
		{
			handleAnimationRunning(true);
		}
		
		private function onPalyEnd(e:FlashEvent):void
		{
			handleAnimationRunning(false);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(view);
			if(touch)
			{
				var point:Point = touch.getLocation(view);
				var cellPoint:Point = DisUtil.coordConver(point,FightConst.CELL_FULL_SIZE);
				var gridPoint:Point = DisUtil.coordConver(cellPoint,1/FightConst.CELL_FULL_SIZE);
				
				if(touch.phase == TouchPhase.BEGAN)
				{
					view.m_Mover.x = gridPoint.x + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.width/2;
					view.m_Mover.y = gridPoint.y + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.height/2;
					view.addChild(view.m_Mover);
					GridModelLineFunc.line(i_GridModel,cellPoint.x,cellPoint.y);
				}
				
				if(touch.phase == TouchPhase.ENDED)
				{
					view.removeChild(view.m_Mover);
					GridModelClearLineFunc.clearLine(i_GridModel);
				}
				
				if(touch.phase == TouchPhase.MOVED)
				{
					if(PosUtil.inLen(point.x,point.y,gridPoint.x + FightConst.CELL_FULL_SIZE_HALF,gridPoint.y + FightConst.CELL_FULL_SIZE_HALF,FightConst.CELL_SIZE_HALF/2))
					{
						view.m_Mover.x = gridPoint.x + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.width/2;
						view.m_Mover.y = gridPoint.y + FightConst.CELL_FULL_SIZE_HALF - view.m_Mover.height/2;
						GridModelLineFunc.line(i_GridModel,cellPoint.x,cellPoint.y);
					}
				}
			}
		}
		
		private function handleAnimationRunning(bool:Boolean):void
		{
			if(bool)
			{
				view.removeEventListener(TouchEvent.TOUCH,onTouch);
			}else{
				view.addEventListener(TouchEvent.TOUCH,onTouch);
			}
		}
	}
}