package gema.util
{
	/**
	 * 创建者: errormee
	 * 修改者:
	 * 说明:
	 */
	public class SortUtil
	{
		/**
		 * 降序
		 * 排序对象需要提供 getSortIndex 方法
		 */
		public static function DESCENDING(a:Object,b:Object):int
		{  
			if(!a.hasOwnProperty("getSortIndex")) return 0;
			if(a.getSortIndex() > b.getSortIndex()){  
				return -1;  
			}else if(a.getSortIndex() < b.getSortIndex()){  
				return 1;  
			}else{  
				return 0;  
			}  
		}
		
		/**
		 * 升序
		 * 排序对象需要提供 getSortIndex 方法
		 */
		public static function ASCENDING(a:Object,b:Object):int
		{  
			if(!a.hasOwnProperty("getSortIndex")) return 0;
			if(a.getSortIndex() < b.getSortIndex()){  
				return -1;  
			}else if(a.getSortIndex() > b.getSortIndex()){  
				return 1;  
			}else{  
				return 0;  
			}  
		}
	}
}