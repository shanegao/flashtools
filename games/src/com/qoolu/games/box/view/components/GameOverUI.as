package com.qoolu.games.box.view.components {
	import flash.events.Event;	
	import flash.text.TextFieldAutoSize;	
	import flash.events.MouseEvent;	
	import flash.display.SimpleButton;	
	import flash.text.TextField;	
	import flash.display.MovieClip;
	
	/**
	 * @author GaoXian
	 */
	public class GameOverUI extends MovieClip 
	{
		public static const SUBMIT :String = "submit";
		public var scoreTxt : TextField ;
		public var submitBtn : SimpleButton ;
		
		
		public function GameOverUI() 
		{
			submitBtn.addEventListener(MouseEvent.CLICK , onClick) ;
		}
		
		private function onClick(evt : MouseEvent)  :void
		{
			trace("submit");
			dispatchEvent(new Event(SUBMIT));
		} 
		
		public function showScore(value : int) : void
		{
			scoreTxt.text = value.toString();
			scoreTxt.autoSize = TextFieldAutoSize.LEFT ;
		}
	}
}
