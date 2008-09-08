package fc.controls 
{
	import flash.display.Sprite;
	/**
	 * 窗口
	 * @author GaoXian
	 */
	public class Window extends UIOjbect
	{
		public var bgMc : Sprite ;
		
		/**
		 * 构造函数
		 */
		public function Window(content:Class)
		{
			initView(new content());
		}
		/**
		 * 设置界面
		 */
		private function initView(content: Sprite) : void
		{
			content.x = (_width - content.width) * .5 ; 
			content.y = (_height - content.height) * .5 ; 
			addChild(content);
			
		}
		/**
		 * 重设大小
		 */
		override protected function resize():void
		{
			bgMc.width = _width ; 
			bgMc.height = _height ; 
		}

	}
}
