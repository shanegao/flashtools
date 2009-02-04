package fc.remote 
{
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import fc.errors.Errors;
	import fc.events.LoadEvent;		

	/**
	 * @author GaoXian
	 * @date  2008-5-14
	 */
	public class AMFConnection extends EventDispatcher
	{
		private var responder  : Responder ; 
		private var connection : NetConnection ; 
		private var _result	   : Object  ;
		private var _failResult: Object ;
		
		private var _gateway   : String ;
		/**
		 * 单例
		 */
		private static var instance : AMFConnection ;  
		public static function getInstance() : AMFConnection
		{
			if(instance == null) instance = new AMFConnection(new Helper()) ;
			return instance ; 
		}
		/**
		 * 构造函数
		 */
		public function AMFConnection(help :Helper) 
		{}
		/**
		 * 初始化连接对象
		 */
		public function initConn() :void
		{
			if(_gateway == null) throw new Error(Errors.URLisEmpty);
			responder = new Responder(onResult, onFault);
			connection = new NetConnection;
			connection.connect(_gateway);
		}
		/**
		 * 调用
		 * @param command 
		 * @param args 其它参数
		 */
		public function call(command : String,...args):void 
		{
			sendEvent(LoadEvent.LOAD_START);
			connection.call(command, responder , args);
		}
		/**
		 * 成功
		 */
		private function onResult(result:Object):void 
		{
			_result = result;
			sendEvent(LoadEvent.LOAD_SUCCESS) ;
		}
		/**
		 * 失败
		 */
		private function onFault(fault:Object):void 
		{
			_failResult = fault ;
			sendEvent(LoadEvent.LOAD_FAILED);
		}
		/**
		 * 发送事件
		 */
		private function sendEvent(type : String) : void
		{
			dispatchEvent(new LoadEvent(type));
		}
		/**
		* Get function for _gateway.
		* @return _gateway : String
		*/
		public function get gateway () : String 
		{
			return _gateway;
		}
		
		/**
		* Set function for _gateway.
		* @param value : String
		*/
		public function set gateway (value : String):void 
		{
			_gateway = value;
			initConn();
		}
		
		public function get result() : Object
		{
			return _result ; 
		}
		
		public function get failResult() : Object
		{
			return _failResult ; 
		}
	}
}
class Helper {
}
