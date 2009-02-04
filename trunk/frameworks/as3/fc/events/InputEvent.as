package fc.events 
{
	import flash.events.Event;
	/**
	 * 文本输入事件
	 * @author GaoXian
	 */
	public class InputEvent extends Event 
	{
		public static const CHANGE : String = "changetext";
		
		public var content : String  ;
		
		public function InputEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
