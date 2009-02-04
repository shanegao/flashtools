package cn.flashcoder.blocky.view.components 
{
	import flash.events.Event;	
	import flash.display.MovieClip;
	import flash.display.SimpleButton ;
	import flash.events.MouseEvent ;
	/**
	 * @author GaoXian
	 * 
	 */
	public class PreviewUI extends MovieClip 
	{
		public var startGameBtn : SimpleButton ;
		public var gameGuideBtn : SimpleButton ;
		public var closeBtn : SimpleButton ;
		
		public static const START :String = "start";
		public static const GUIDE :String = "guide";
		public static const CLOSE :String = "close";
		public function PreviewUI() 
		{
			trace("prview create!");
			initButton();
		}
		
		private function initButton() : void
		{
			startGameBtn.addEventListener(MouseEvent.CLICK , onClick);
			gameGuideBtn.addEventListener(MouseEvent.CLICK , onClick);
			closeBtn.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(evt : MouseEvent) : void
		{
			var target : SimpleButton = evt.target as SimpleButton ;
			switch(target)
			{
				case startGameBtn :
					dispatchEvent(new Event(START)) ;
					break ;
				case gameGuideBtn : 
					dispatchEvent(new Event(GUIDE)) ;
					break ;
				case closeBtn :
					dispatchEvent(new Event(CLOSE)) ;
					break ;				
			
			}
		}
		
	}
}
