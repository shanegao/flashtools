package com.qoolu.games.box.view.components {
	import flash.display.Sprite;	
	import flash.events.Event;	
	import flash.text.TextFieldAutoSize;	
	import flash.events.MouseEvent;	
	import flash.display.SimpleButton;	
	import flash.text.TextField;	
	import flash.display.MovieClip;
	
	/**
	 * @author GaoXian
	 * 游戏结束界面
	 */
	public class GameOverUI extends MovieClip 
	{
		public static const SUBMIT :String = "submit";
		public var beikeTxt : TextField ;
		public var scoreTextMc : Sprite ;
		public var submitBtn : SimpleButton ;
		public var iconMc : Sprite ;
		
		public function GameOverUI() 
		{
			submitBtn.addEventListener(MouseEvent.CLICK , onClick) ;
		}
		
		private function onClick(evt : MouseEvent)  :void
		{
			dispatchEvent(new Event(SUBMIT));
		} 
		
		public function showScore(value : int) : void
		{
			//scoreTxt.text = value.toString()+"(" + Math.floor(value*.04)+ "贝壳)";
			scoreTextMc["scoreTxt"].text = value.toString(); 
			scoreTextMc["scoreTxt"].text = Math.floor(value*.04 )+ "" ;
			scoreTextMc["scoreTxt"].autoSize = TextFieldAutoSize.LEFT ;
			scoreTextMc["scoreTxt"].width = scoreTextMc["scoreTxt"].textWidth + 4 ;
			scoreTextMc.x = (width - scoreTextMc.width) / 2 ;
			//scoreTextMc.y = (height - scoreTextMc.height) / 2 ;
			//
			//
			beikeTxt.text = Math.floor(value*.04 )+ "" ;
			beikeTxt.autoSize = TextFieldAutoSize.LEFT ;
			beikeTxt.width = beikeTxt.textWidth + 4 ;
			iconMc.x = beikeTxt.x + beikeTxt.width + 2; 
			//
		}
	}
}
