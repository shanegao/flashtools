package com.qoolu.games.box.view.components
{
	import flash.display.Sprite;	
	import flash.events.Event;	
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;	
	/**
	 * @author Gaoxian
	 */
	public class ScoreMovie extends Sprite 
	{
		public static const DISTROY : String = "distroy";
		private function playOver() : void
		{
			trace("play over....................");
			
			for(var i :int =0 ; i < numChildren ; i++)
			{
				var item : MovieClip = this.getChildAt(i) as MovieClip ;
				item.stop();
			}
			dispatchEvent(new Event(DISTROY));
		}
		
		public function showScore(score : int) : void
		{
			var s : String = score.toString();
			for(var i : int =0 ; i < s.length ; i++)
			{
				var className : Class = getDefinitionByName("Num" + s.charAt(i)) as Class ; 
				var item : MovieClip = new className() as MovieClip ;
				item.name = "num" + s.charAt(i);
				item.addFrameScript(item.totalFrames-1 , playOver);
				item.x = 36 * i;
				addChild(item);
			}
		}
	}
}
