package com.qoolu.games.box.view.components {
	import flash.display.Sprite;	
	import flash.display.MovieClip;
	
	/**
	 * @author Gaoxian
	 */
	public class BoxesUI extends MovieClip 
	{
		//private var container : Sprite ;

		public function BoxesUI(nums : Object)
		{
			trace("BoxesUI  : "  +nums);
			var wNum : int = nums[0] as int ;
			var hNum : int = nums[1] as int;
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
		
		
		
	}
}
