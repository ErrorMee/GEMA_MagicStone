package gema.util
{
	/******************************************************
	 *
	 * 创建者：cory
	 * 功能：
	 * 说明：
	 *
	 ******************************************************/
	
	public class PosUtil
	{
		/** 无 0 **/
		public static const DIR_NULL:int			= 0;
		/** 左上 1 **/
		public static const DIR_LEFT_TOP:int		= 1;
		/** 上 2 **/
		public static const DIR_TOP:int				= 2;
		/** 右上 3 **/
		public static const DIR_RIGHT_TOP:int		= 3;
		/** 左 4 **/
		public static const DIR_LEFT:int			= 4;
		/** 中间 5 **/
		public static const DIR_CENTER:int			= 5;
		/** 右 6 **/
		public static const DIR_RIGHT:int			= 6;
		/** 左下 7 **/
		public static const DIR_LEFT_BOT:int		= 7;
		/** 下 8 **/
		public static const DIR_BOT:int				= 8;
		/** 右下 9 **/
		public static const DIR_RIGHT_BOT:int		= 9;
		
		public static function get4Dir(srcX:Number,srcY:Number,toX:Number,toY:Number):int
		{
			var xLen:Number = toX - srcX;
			var yLen:Number = toY - srcY;
			var len:Number = Math.sqrt(xLen*xLen + yLen*yLen);
			
			if(len < 10)
			{
				return DIR_NULL;
			}else{
				if(xLen == 0)
				{
					if(yLen > 0)
					{
						return DIR_TOP;
					}else{
						return DIR_BOT;
					}
				}else{
					if(yLen == 0)
					{
						if(xLen > 0)
						{
							return DIR_RIGHT;
						}else{
							return DIR_LEFT;
						}
					}else{
						var radians:Number = Math.atan2(yLen,xLen);
						var degrees:Number = radians*180/Math.PI;
						
						if(degrees <= -45 && degrees >= -135)
						{
							return DIR_TOP;
						}
						
						if(degrees <= 135 && degrees >= 45)
						{
							return DIR_BOT;
						}
						
						if(xLen > 0)
						{
							return DIR_RIGHT;
						}else{
							return DIR_LEFT;
						}
						
						return DIR_BOT;
					}
				}
			}
			return DIR_NULL;
		}
		
		public static function getLen(srcX:Number,srcY:Number,toX:Number,toY:Number):int
		{
			return Math.sqrt(Math.pow((srcX - toX),2) + Math.pow((srcY - srcY),2));
		}
		
		public static function inLen(srcX:Number,srcY:Number,toX:Number,toY:Number,len:int):Boolean
		{
			var myLen:int = getLen(srcX,srcY,toX,toY);
			if(myLen <= len)
			{
				return true;
			}
			return false;
		}
	}
}