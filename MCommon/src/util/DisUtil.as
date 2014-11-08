package util
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;

	public class DisUtil
	{
		/**
		 * 设置注册点
		 * @param type 对齐方式 共九个点 DirUtil
	     *  <pre>
	     *  1 - 2 - 3
	     *  | / | / |
	     *  4 - 5 - 6
	     *  | / | / |
	     *  7 - 8 - 9
	     *  </pre>
		 * @param posChange 为TRUE时会影响视图
		 */
		public static function pivot(dis:DisplayObject,type:int = 5,posChange:Boolean = false):void
		{
			if(dis == null)
			{
				return;
			}
			if(type < 1 || type > 9)
			{
				return;
			}
			
			var xis:Array = [0,0.5,1];
			var xisX:int = (type - 1)%3;//0,1,2
			var xisY:int = Math.ceil(type/3) - 1;//0,1,2
			var toPivotX:Number = dis.width*xis[xisX];
			var toPivotY:Number = dis.height*xis[xisY];
			
			if(toPivotX != dis.pivotX)
			{
				if(!posChange)
				{
					dis.x += (toPivotX - dis.pivotX);
				}
				dis.pivotX = toPivotX;
			}
			
			if(toPivotY != dis.pivotY)
			{
				if(!posChange)
				{
					dis.y += (toPivotY - dis.pivotY);
				}
				dis.pivotY = toPivotY;
			}
		}
		
		public static function move(dis:DisplayObject,mx:int = 0,my:int = 0):void
		{
			if(dis == null)
			{
				return;
			}
			dis.x = mx;
			dis.y = my;
		}
		
		/**
		 * 坐标转换
		 */
		public static function coordConver(point:Point,rate:Number):Point
		{
			var newPoint:Point = new Point;
			newPoint.x = int(point.x/rate);
			newPoint.y = int(point.y/rate);
			return newPoint;
		}
	}
}