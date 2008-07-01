package com.qoolu.games.box.view.components {
	import flash.events.Event;	
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	import flash.display.MovieClip;
	
	/**
	 * @author Sam
	 */
	public class CutdownTimer extends MovieClip 
	{
		/**
		 * @event Cutdown
		 */
		public static const RUNNING  : String = "running";
		public static const OVER : String = "timeisover";
		
		private var nowTime : Number = 0 ;
		private var ONESECOND : Number = 1000 ;
		private var bgMc : MovieClip ;
		private var precentMc : MovieClip ;
		private var offsetX : Number = 5 ;
		private var totalTime : Number = 0 ;
		private var timer : Timer ;
		public var precent : Number = 0 ;
		public function CutdownTimer(skin : MovieClip) 
		{
			bgMc = skin["bgMc"];
			precentMc = skin["precentMc"];
		}
		/**
		 * @param _totalTime second
		 */
		public function start (_totalTime : Number) : void
		{
			if(_totalTime == 0)return ;
			nowTime = totalTime = _totalTime ;
			timer = new Timer(ONESECOND, totalTime);
			timer.addEventListener(TimerEvent.TIMER, running);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, over);
			timer.start();
		}

		private function running (evt : TimerEvent) : void
		{
			dispatchEvent(new Event (RUNNING));
			nowTime -- ;
			precent = Math.round ((nowTime / totalTime) * 100);
			if(precent <= 100 && precent >= 0)	update (precent);
		}
		
		private function update (p : Number) : void
		{
			precentMc.x = bgMc.x + offsetX ;
			precentMc.width = p * (bgMc.width - 2 * offsetX) / 100 ; 
		}
		
		private function over(evt : TimerEvent) : void
		{
			dispatchEvent(new Event(OVER));
			update(0);
		}
				
	}
}
