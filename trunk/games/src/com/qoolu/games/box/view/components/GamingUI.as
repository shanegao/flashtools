package com.qoolu.games.box.view.components {
	import flash.events.Event;	
	import flash.display.MovieClip;
	
	/**
	 * @author Administrator
	 */
	public class GamingUI extends MovieClip 
	{
		public var board : MovieClip ;
		public var scoreMc : MovieClip ;
		public var cutdownMc : MovieClip ;
		
		private var cutdownTimer : CutdownTimer ;
		
		public function GamingUI()
		{
			trace("GamingUI created ! " + cutdownMc);
			initUI();
		}
		
		public function build(nums : Object, roles:Object) : void
		{
			
		}

		private function initUI() :void
		{
			cutdownTimer = new CutdownTimer(cutdownMc);
			cutdownTimer.addEventListener(CutdownTimer.OVER, gameOver) ;
			cutdownTimer.addEventListener(CutdownTimer.RUNNING, gameRunning) ;
			cutdownTimer.start(10) ;
		}
		private function gameRunning(evt : Event) : void
		{
			trace("gameRunning=================="); 
		}
		
		private function gameOver(evt : Event)  :void
		{
			trace("gameOver======================");
		}
		
		
	}
}
