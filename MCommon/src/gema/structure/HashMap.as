package gema.structure
{
	import flash.utils.Dictionary;
	
	/**
	 * 创建者: web
	 * 修改者: errormee
	 * 说明:
	 */
	public class HashMap
	{
		private var m_Dict:Dictionary = null;
		private var m_KeyList:Array = null;
		
		public function HashMap(weakKeys:Boolean=false)
		{
			m_Dict = new Dictionary();
			m_KeyList = [];
		}
		
		public function put(key:Object, value:Object):void
		{
			if(key != null)
			{
				m_KeyList.push(key);
				m_Dict[key] = value;
			}
			else
			{
				throw new ArgumentError("cannot put a value with undefined or null key!");
			}
		}
		
		public function get(key:Object,isDelete:Boolean = false):Object
		{
			var value:Object = m_Dict[key];
			if(isDelete)
			{
				removeAt(key);
			}
			return value;
		}
		
		public function removeAt(key:Object):void
		{
			var i:int = m_KeyList.indexOf(key);
			if(i != -1)
			{
				m_KeyList.splice(i, 1);
			}
			if(m_Dict[key])
			{
				delete m_Dict[key];
			}
		}
		
		public function clear():void
		{
			m_KeyList.length = 0;
			m_KeyList = [];
			for(var key:Object in m_Dict)
			{
				delete m_Dict[key];
			}
		}
		
		public function indexOf(value:Object):int
		{
			var i:int = 0;
			for(var key:Object in m_Dict)
			{
				if(m_Dict[key] == value)
				{
					return i;
				}
				i++;
			}
			return -1;
		}
		
		public function length():int
		{
			return m_KeyList.length;
		}
		
		public function isEmpty():Boolean
		{
			return m_KeyList.length == 0;
		}
		
		public function clone():HashMap
		{
			var hashMap:HashMap = new HashMap();
			for each(var key:Object in m_KeyList)
			{
				hashMap.keyList.push(key);
				hashMap.put(key, m_Dict[key]);
			}
			return hashMap;
		}
		
		public function containsKey(key:Object):Boolean
		{
			for each(var k:Object in m_KeyList)
			{
				if(k === key)
				{
					return true;
				}
			}
			return false;
		}
		
		public function containsValue(value:Object):Boolean
		{
			for each(var v:Object in m_Dict)
			{
				if(v === value)
				{
					return true;
				}
			}
			return false;
		}
		
		public function toString():String
		{
			var str:String = "HashMap Content:\n";
			for each(var key:Object in m_KeyList)
			{
				str += key + " -> " + m_Dict[key] + "\n";
			}
			return str;
		}
		
		public function get dict():Dictionary
		{
			return m_Dict;
		}
		
		public function get keyList():Array
		{
			return m_KeyList;
		}
		
		public function set keyList(value:Array):void
		{
			m_KeyList = value;
		}
		
		public function shift():Object
		{
			var key:Object;
			if(m_KeyList && m_KeyList.length>0)
			{
				key = m_KeyList.shift();
			}
			
			if(key)
			{
				return get(key,true);
			}
			return null;
		}
		
	}
}