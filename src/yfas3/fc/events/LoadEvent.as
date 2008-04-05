package fc.events 
{
	import flash.events.Event;
	
	/**
	 * 加载事件
	 * @author GaoXian
	 * @version ActionScript3.0
	 */
	public class LoadEvent extends Event 
	{
		/**
		* 当加载成功时触发
		*/		
		public static const LOAD_SUCCESS:String = "loadSuccess";
		/**
		* 当加载失败时触发
		*/		
		public static const LOAD_FAILED:String = "loadFailed";
		/**
		* 当正在加载中触发
		*/		
		public static const LOADING:String = "loading";
		/**
		* 当出现超时状态时触发
		*/		
		public static const TIMEOUT:String = "timeout";
		
		/**
		* 事件对象的名称
		*/		
		public var name:String = "";
		/**
		* 当前已经加载的byte数
		*/		
		public var totalBytes:Number = 0;
		/**
		* 总共需要加载的byte数
		*/		
		public var loadedBytes:Number = 0;
		/**
		* 当前已经加载的百分比
		*/		
		public var loadedRate:Number = 0;
		/**
		* 加载的数据对象
		*/		
		public var data:*;
		/**
		 * 加载失败出错信息
		 */
		public var errorMsg  :String ;
		/**
		 * 构造函数
		 */
		public function LoadEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
