package fc.controls 
{
	import flash.display.Sprite;
	
	/**
	 * 组件基类
	 * @author GaoXian
	 */
	public class UIComponent extends Sprite
	{
		
		protected var _width : Number  ;
		protected var _height : Number ; 
		
		/**
		 * 构造函数
		 */
		public function UIComponent()
		{
		}
		/**
		 * 重新设置大小
		 */
		protected function resize() : void
		{
		}
		
		override public function set width(w : Number) : void
		{
			_width = w ;
		}
		
		override public function get width() : Number
		{
			return _width ; 
		}
		
		
		override public function set height(h : Number) : void
		{
			_height = h ;
		}
		
		override public function get height() : Number
		{
			return _height ; 
		}
		
	}
}
