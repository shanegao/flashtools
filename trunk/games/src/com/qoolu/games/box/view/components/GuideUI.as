package com.qoolu.games.box.view.components {
	import flash.events.Event;	
	import flash.events.MouseEvent;	
	import flash.display.SimpleButton;	
	import flash.display.MovieClip;
	
	/**
	 * @author Gaoxian
	 * 游戏指南
	 */
	public class GuideUI extends MovieClip 
	{
		public var startGameBtn : SimpleButton ;

		public static const START : String = "start...";
		
		private static var instance : GuideUI ;
		
		public static function getInstance() : GuideUI
		{
			if(instance == null) instance = new GuideUI();
			return instance as GuideUI ;
		}

		public function GuideUI() 
		{
			initButton() ;
		}
		
		private function initButton() : void
		{
			startGameBtn.addEventListener(MouseEvent.CLICK, onClick) ;
		}
		
		private function onClick(evt : MouseEvent) : void
		{
			dispatchEvent(new Event(START)) ;
		}
	}
}
