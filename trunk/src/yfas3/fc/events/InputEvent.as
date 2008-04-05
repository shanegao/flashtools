package fc.events 
{
	import flash.events.Event;
	/**
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
