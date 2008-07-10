package com.qoolu.games.box.view.components {
	import flash.events.Event;	
	import flash.display.MovieClip;
	
	/**
	 * @author Administrator
	 */
	public class ScoreMovie extends MovieClip 
	{
		public var num0 : MovieClip ;
		public var num1 : MovieClip ;
		public var num2 : MovieClip ;
		public var num3 : MovieClip ;
		public var num4 : MovieClip ;
		public var num5 : MovieClip ;
		public var num6 : MovieClip ;
		public var num7 : MovieClip ;
		public var num8 : MovieClip ;
		public var num9 : MovieClip ;
		
		public static const DISTROY : String = "";
		public function ScoreMovie() 
		{
			allInvisible();
		}
		
		private function allInvisible() : void
		{
			for(var i :int =0 ; i < 10 ; i ++)
			{
				var item : MovieClip = this["num" + i] as MovieClip ;
				item.x = 0 ;
				item.y = 0 ;
				item.visible = false ;
			}
		}
		
		private function playOver() : void
		{
			trace("play over....................");
			for(var i :int =0 ; i < 10 ; i ++)
			{
				var item : MovieClip = this["num" + i] as MovieClip ;
				item.stop();
			}
			dispatchEvent(new Event(DISTROY));
		}
		
		public function showScore(score : int) : void
		{
			var s : String = score.toString();
			for(var i : int =0 ; i < s.length ; i++)
			{
				var item : MovieClip = this["num" + s.charAt(i)] as MovieClip ; 
				item.addFrameScript(item.totalFrames-1 , playOver);
				item.visible = true ;
				item.x = 36 * i;
			}
		}
	}
}
