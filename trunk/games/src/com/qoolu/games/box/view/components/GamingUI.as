package com.qoolu.games.box.view.components {
	import com.qoolu.games.box.view.components.blockys.RedBlocky;	
	
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
			
			var wNum : int = nums[0] as int ;
			var hNum : int = nums[1] as int ;
			for(var i : int = 0 ; i <wNum ; i++)
			{
				var xx : Number = i * 25 ;
				for(var j : int = 0 ; j < hNum ; j++)
				{
					var s : Sprite = new Sprite();
					s.graphics.beginFill(0xFF0000,1);
					s.graphics.drawRect(0, 0, 20, 20);
					s.graphics.endFill();
					addChild(s);
					s.x = xx ;
					s.y = 25 * j ;
					//trace(s.x , s.y);
				}
			}
		}

		private function initUI() :void
		{
			cutdownTimer = new CutdownTimer(cutdownMc);
			cutdownTimer.addEventListener(CutdownTimer.OVER, gameOver) ;
			cutdownTimer.addEventListener(CutdownTimer.RUNNING, gameRunning) ;
			cutdownTimer.start(10) ;
			
			//
			board.addChild(new RedBlocky()) ;
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
