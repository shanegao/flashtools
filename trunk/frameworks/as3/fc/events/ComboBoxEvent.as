package fc.events 
{
	import flash.events.Event;
	/**
	 * ComboBox 事件
	 * @author GaoXian
	 */
	public class ComboBoxEvent extends Event 
	{
		/**
		 * 选中事件
		 */
		public static const SELECTED : String = "select";
		
		/**
		 * 构造函数
		 */
		public function ComboBoxEvent( type : String, 
									 bubbles : Boolean = false, 
									 cancelable : Boolean = false )
		{
			super(type, bubbles, cancelable);
		}
	}
}
