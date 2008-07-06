package com.qoolu.games.box.view.components 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton ;
	import flash.events.MouseEvent ;
	/**
	 * @author GaoXian
	 */
	public class Preview extends MovieClip 
	{
		public var startGameBtn : SimpleButton ;
		public var gameGuideBtn : SimpleButton ;
		public function Preview() 
		{
			trace("prview create!");
			initButton();
		}
		
		private function initButton() : void
		{
			//startGameBtn.addEventListener(MouseEvent.CLICK , startGame);
			//gameGuideBtn.addEventListener(MouseEvent.CLICK , gameGuid);
		}
		
		private function startGame(evt : MouseEvent) : void
		{
			trace("start game");
		}
		
		private function gameGuid(evt : MouseEvent) : void
		{
			trace("guide");
		}
	}
}
