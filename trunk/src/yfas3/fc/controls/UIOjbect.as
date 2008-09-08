package fc.controls
{
	import flash.display.Sprite;
	
	public class UIObject
	{	
		private var needOverrideError :String = "need to override onResize Method";
		//构造函数
		public var targetMc : Sprite ;
		public function UIObject(target : Sprite ,...params)
		{
			targetMc = target ;
			//初始化界面
			initUI();
		}
		public function initUI() : void
		{
			throw new Error(needOverrideError);
		}
		//resize
		private var __width  :Number , __height : Number ;
		public function set width(w :Number):void
		{
			__width = w ; 
			onResize();
		}
		
		public function get width():Number
		{
			return __width ;
		}
		
		public function set height(h : Number):void
		{
			__height = h ;
			onResize();
		}
		
		public function get height() : Number
		{
			return __height ;
		}
		/**
		 * 重新设置长宽后 , 重新布局
		 */ 
		public function onResize(): void
		{
			throw new Error(needOverrideError);
		} 
	}
}
	