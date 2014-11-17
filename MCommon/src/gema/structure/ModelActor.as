package gema.structure
{
	import flash.events.Event;
	
	import gema.Module.interfaces.IDisposeObject;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class ModelActor extends Actor implements IDisposeObject
	{
		public function ModelActor()
		{
			super();
		}
		
		public function addEventListener(type:String,listener:Function):void
		{
			_eventDispatcher.addEventListener(type,listener);
		}
		
		public function removeEventListener(type:String,listener:Function):void
		{
			_eventDispatcher.removeEventListener(type,listener);
		}
		
		public function publicDispatch(event:Event):Boolean
		{
			return dispatch(event);
		}
		
		public function clear():void
		{
		}
		
		public function dispose():void
		{
		}
	}
}