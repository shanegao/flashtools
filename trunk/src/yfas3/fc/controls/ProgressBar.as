package fc.controls 
{
	import flash.display.Sprite;
	/**
	 * @author GaoXian
	 * loading 条
	 */
	public class ProgressBar extends Sprite 
	{
		public var barMc : Sprite ; 
		public var bgMc  : Sprite ; 

		private var _width : Number = 100 ;
		private var _height : Number = 11 ;
		private var _precent : Number = 0 ;
		
		public function ProgressBar()
		{
			super();
			resize();
		}

		
		private function resize():void
		{
			bgMc.width = _width ; 
			bgMc.height = _height ; 
			barMc.height = _height - 2 ;
			barMc.width = int(_precent * bgMc.width) / 100 - 2;
		}
		
		public function set precent(p : Number):void
		{
			if(p >= 0 && p <= 100) 
			{
				_precent = p ; 
				resize();
			}
		}

		
		override public function set width(w :Number):void
		{
			_width = w ; 
			resize();
		}
		
		override public function get width():Number
		{
			return _width ;
		}
		
		override public function set height(h : Number):void
		{
			_height = h ;
			resize();
		}
		
		override public function get height() : Number
		{
			return _height ;
		}
		
	}
}
/**test
		import com.qihoo.paopaotu.controls.* ; 
		var pb : YFProgressBar = new YFProgressBar();
		pb.x = 100 ;
		pb.y = 200 ;
		addChild(pb);
		var timer : Timer = new Timer(100);
		timer.addEventListener(TimerEvent.TIMER,onTimer);
		timer.start();
		var i :int = 0 ;
		function onTimer(evt : TimerEvent)
		{
			trace(i);
			pb.precent = i++ ;
			if(i > 100 )Timer(evt.target).stop();
		}
*/