package fc.controls 
{
	import flash.display.DisplayObject;	
	import flash.events.MouseEvent;	
	import flash.display.Sprite;
	/**
	 * @author GaoXian
	 * @date  2008-4-14
	 */
	public class ScrollPane extends Sprite 
	{
		private var sWidth : Number ;
		private var sHeight : Number ; 
		public var bgMc : Sprite ; 
		private var maskMc : Sprite ;
		private var contentMc : Sprite ;  
		private var _content : DisplayObject ; 

		private var startX : Number ; 
		private var startY : Number ; 
		private var enableMoveV : Boolean ; 
		private var enableMoveH : Boolean ; 
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
			bgMc = new Sprite();
			bgMc.graphics.beginFill(0x999999) ; 
			bgMc.graphics.drawRect(0, 0, sWidth, sHeight);
			bgMc.graphics.endFill() ;
			addChild(bgMc);
			contentMc = new Sprite();
			contentMc.name = "contentMc";
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
			var t : Sprite = Sprite(evt.target) ; 
			t.addEventListener(MouseEvent.MOUSE_MOVE, onMove) ;
			startX = evt.localX ; 
			startY = evt.localY ; 
			trace("onDown : "  +((parent !=null)));
			if(this.stage !=null) this.stage.addEventListener(MouseEvent.MOUSE_UP, onUpOutside) ; 
		}

		/**
		 * 鼠标移动
		 */
		private function onMove(evt : MouseEvent) : void
		{
			
			if(evt.currentTarget == contentMc)
			{
				trace("onMove. " + evt.currentTarget);
				var t : Sprite = evt.currentTarget as Sprite ;
				if(enableMoveV) 
				{
					t.x += evt.localX - startX ; 
					if(t.x >= 0)t.x = 0 ;
					if(t.x <= t.width - bgMc.width) t.x = t.width - bgMc.width ;
				}
				if(enableMoveH)
				{
					t.y += evt.localY - startY ;
					if(t.y >= 0) t.y = 0 ;
					if(t.y <=  bgMc.height- t.height ) t.y = bgMc.height- t.height;
				}
				evt.updateAfterEvent() ;
			}
	
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
		/**
		 * onReleaseOutside
		 * 在目标外松开鼠标
		 */
		private function onUpOutside(evt : MouseEvent) : void
		{
			trace("onUpOutside----------")  ;
			var t : Sprite = evt.target as Sprite ;
			if(t == contentMc)	
			{
				trace("in : "+(t == contentMc));
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
		public function set content(__content : DisplayObject) : void
		{
			if(_content!=null && contains(_content)) contentMc.removeChild(_content) ;
			_content = __content ; 
			contentMc.addChild(_content); 
			contentMc.x = (sWidth - contentMc.width) * .5;
			contentMc.y = (sHeight - contentMc.height) *.5 ; 
			enableMoveV = _content.width > bgMc.width ; 
			enableMoveH = _content.height > bgMc.height ; 
			contentMc.mask = maskMc ; 
			setEvent(contentMc);
		} 
		/**
		 * get 图像
		 */
		public function get content() : DisplayObject
		{
			return _content ; 
		}  
	}
}
