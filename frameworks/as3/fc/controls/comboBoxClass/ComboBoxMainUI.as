package fc.controls.comboBoxClass 
{
	import flash.text.TextField;	
	import flash.display.Sprite;
	
	/**
	 * 界面
	 * @author GaoXian
	 */
	public class ComboBoxMainUI extends Sprite 
	{
		/**
		 * 界面元件
		 */
		public var downArrowButton : Sprite ;
		public var selectedTxt : TextField ;
		public var bgMc : Sprite ;
		/**
		 * 私有成员
		 */
		private var _width : Number ;
		private var _height : Number ;
		
		/**
		 * 构造函数
		 */
		public function ComboBoxMainUI(label : String,_w : Number,_h: Number)
		{
			trace("构造一个ComboBoxMainUI");
			selectedTxt.text = label ;
			_width = _w ;
			_height = _h ;
			buildUI();
			this.mouseChildren = false ;
		}
		/**
		 * 更新界面
		 */
		private function buildUI():void
		{
			downArrowButton.x = _width - downArrowButton.width - 5 ;
			selectedTxt.width = downArrowButton.x - selectedTxt.x - 2 ;
			bgMc.width = _width ;
		}
		/**
		 * set 文本框内容
		 * @param txt String
		 */
		public function set selectedText(txt : String):void
		{
			selectedTxt.text = txt ; 
		}
		/**
		 * get 文本框内容
		 */
		public function get selectedText() : String
		{
			return selectedTxt.text ;
		}
	}
}
