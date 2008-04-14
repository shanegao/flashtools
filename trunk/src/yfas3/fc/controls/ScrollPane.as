package fc.controls {
	import flash.events.MouseEvent;	
	import flash.display.Bitmap;	
	import flash.display.Sprite;
	/**
	 * @author GaoXian
	 * @date  2008-4-14
	 */
	public class ScrollPane extends Sprite 
	{
		private var sWidth : Number ;
		private var sHeight : Number ; 
		
		private var maskMc : Sprite ;
		private var contentMc : Sprite ;  
		private var _content : Bitmap ; 
		
		private var startX : Number ; 
		private var startY : Number ; 
		/**
		 * 构造函数
		 */
		public function ScrollPane(_sWidth : Number , _sHeight: Number)
		{
			sWidth = _sWidth; 
			sHeight = _sHeight ; 
			initView();
		}
		/**
		 * 初始化界面
		 */
		private function initView() : void
		{
			contentMc = new Sprite();
			setEvent(contentMc);
			maskMc = new Sprite();
			maskMc.graphics.beginFill(0xff0000) ; 
			maskMc.graphics.drawRect(0, 0, sWidth, sHeight);
			maskMc.graphics.endFill() ;
			addChild(contentMc);
			addChild(maskMc);
		}
		/**
		 * 添加侦听
		 */
		private function setEvent(target  : Sprite) : void
		{
			target.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			target.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}

		/**
		 * 鼠标按下
		 */
		private function onDown(evt  : MouseEvent) : void
		{
			var t : Sprite = Sprite(evt.currentTarget) ; 
			t.addEventListener(MouseEvent.MOUSE_MOVE, onMove) ;
			startX = evt.localX ; 
			startY = evt.localY ; 
			trace("onDown : "  +((parent !=null)));
			if(this.stage !=null)this.stage.addEventListener(MouseEvent.MOUSE_UP, onUpOutside) ; 
		}

		/**
		 * 鼠标移动
		 */
		private function onMove(evt : MouseEvent) : void
		{
			var t : Sprite = evt.currentTarget as Sprite ;
			t.x += evt.localX - startX ; 
			t.y += evt.localY - startY ;
			evt.updateAfterEvent() ;
			//t.startDrag();
		}
		/**
		 * 鼠标松开
		 */
		private function onUp(evt : MouseEvent) : void
		{
			var t : Sprite = evt.currentTarget as Sprite ;
			t.removeEventListener(MouseEvent.MOUSE_MOVE, onMove) ;
			//t.stopDrag();
		}
		private function onUpOutside(evt : MouseEvent) : void
		{
			trace("onUpOutside----------")  ;
			
			var t : Sprite = evt.target as Sprite ;
			if(t == contentMc)	
			{
				trace("onUpOutside : "+(t == parent));
				
			}
			else
			{
				contentMc.removeEventListener(MouseEvent.MOUSE_MOVE, onMove) ;
				this.stage.removeEventListener(MouseEvent.MOUSE_UP, onUpOutside) ; 
			}
		}
		/**
		 * set 图像
		 */
		public function set content(__content : Bitmap) : void
		{
			_content = __content ; 
			contentMc.addChild(_content); 
			_content.x = (sWidth - _content.width) * .5;
			_content.y = (sHeight -_content.height) *.5 ; 
			contentMc.mask = maskMc ; 
		} 
		 
		
	}
}
