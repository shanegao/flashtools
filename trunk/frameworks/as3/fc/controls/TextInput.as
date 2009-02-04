package fc.controls 
{
	import fc.events.InputEvent;	
	
	import flash.events.Event;	
	import flash.text.TextField;	
	import flash.display.Sprite;
	
	/**
	 * 输入框组件
	 * @author GaoXian
	 */
	public class TextInput extends Sprite 
	{
		public var inputTxt : TextField ; 
		public var limitTxt : TextField ; 
		public var bgMc		: Sprite ; 
		public var limitBgMc: Sprite ; 

		private var _charNum : int = 50;
		private var _w : Number = 220; 
		private var _h : Number = 20 ;
		/**
		 * 构造函数
		 */
		public static var instance : TextInput ; 
		public static function getInstance(w : Number , h : Number , maxChar : int) : TextInput
		{
			if(instance == null) return instance = new TextInput(w,h,maxChar);
			else return instance ; 
		}
		public function TextInput(w : Number , h : Number , maxChar : int)
		{
			_charNum = maxChar ; 
			_w = w ; _h = h ; 
			initListener();
			initView();
		}
		/**
		 * 初始化界面
		 */
		private function initView() : void
		{
			inputTxt.maxChars = _charNum ; 
			limitBgMc.x = _w - limitBgMc.width ; 
			bgMc.width = limitBgMc.x - 2 ;
			inputTxt.height = bgMc.height = limitBgMc.height = limitTxt.height = _h ; 
		}

		/**
		 * 初始化侦听
		 */
		private function initListener() : void
		{
			inputTxt.addEventListener(Event.CHANGE, onTextChange) ; 
		}
		/**
		 * 文本内容改变
		 */
		private function onTextChange(evt : Event) : void
		{
			var limitStr : String = String(_charNum - inputTxt.text.length) ; 
			limitTxt.text =  limitStr; 
			
			var e : InputEvent = new InputEvent(InputEvent.CHANGE) ;
			e.content = inputTxt.text ; 
			dispatchEvent(e) ; 
		}

		/**
		 * get 输入内容
		 */
		public function set content(_text : String)  :void
		{
			inputTxt.text = _text ; 
		}

		public function get content() : String
		{
			return inputTxt.text ; 
		} 
	}
}
