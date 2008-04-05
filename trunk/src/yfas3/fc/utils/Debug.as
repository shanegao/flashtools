package fc.utils 
{
	import flash.net.LocalConnection;
	import flash.events.StatusEvent;	
	/**
	 * 调试类 LocalConnection
	 * @author GaoXian
	 */
	public class Debug 
	{
		private static var enable : Boolean = false ;
		/**
		 * 输出
		 */
		public static function out(msg:*):void
		{
			if(enable)
			{
				var sending_lc:LocalConnection = new LocalConnection();
				sending_lc.send("bug_name", "methodToExecute",msg);
				sending_lc.addEventListener(StatusEvent.STATUS,onStatus);
			}
		}
		/**
		 * 侦听LocalConnection状态
		 */
		private static function onStatus(e:StatusEvent):void
		{
			 switch (e.level) 
			 {
             	case "status":
             		trace("LocalConnection.send() succeeded");
                    break;
                case "error":
                	enable = false ;
                    trace("LocalConnection.send() failed");
                    break;
            }	
		}
	}
}
