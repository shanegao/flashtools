package fc.controls 
{
	import flash.display.Sprite;
	/**
	 * @author GaoXian
	 * 
	 * 加载进度条
	 */
	public class Loading extends UIObject 
	{
		/**
		 * barMc 前景动画 
		 * bgMc 背景动画
		 */ 
		public var barMc : Sprite , bgMc : Sprite; 
		private var _precent : Number = 0 ;
		
		//设置进度条
		public function set percent(p : Number):void
		{
			if(p >= 0 && p <= 100) 
			{
				_precent = p ; 
				onResize();
			}
		}
		override protected function initUI():void
		{
			barMc = targetMc["barMc"];
			bgMc = targetMc["bgMc"];
			percent = 0 ; 
			bgMc.width = __width ; 
			bgMc.height = __height ; 
		}
		override protected function onResize():void
		{
			barMc.height = __height - 2 ;
			barMc.width = int(_precent * bgMc.width) / 100 - 2;
		}
	}
}