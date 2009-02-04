package cn.flashcoder.blocky.view.components.manager 
{
	import flash.media.Sound;	
	import flash.utils.getDefinitionByName;	
	/**
	 * @author GaoXian
	 */
	public class SoundManager 
	{
		//按钮
		public static const BUTTON_ON : String = "ButtonSound";
		//每一关初始音乐效果
		public static const INIT_LEVEL : String = "InitSound";
		//物品不能消除的音效
		public static const FAIL_REMOVE : String = "FailSound";
		//物品消除的音效
		public static const REMOVE_PET : String = "RemoveSound";
		//消除已经消过的
		public static const REMOVE_BLANK : String = "RmBlankSound";
		//游戏结束.
		public static const GAME_OVER : String = "GameOverSound";
		
		public static function play(name : String) : void
		{
			var className : Class = getDefinitionByName(name) as Class ;
			(new className() as Sound).play();
		}
	}
}
