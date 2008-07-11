package com.qoolu.games.box.view.components.blockys 
{
	import flash.display.MovieClip;	
	import flash.display.Sprite;
import flash.utils.getDefinitionByName;	
	/**
	 * @author Gaoxian
	 * 方块基类
	 */
	 
	public class Blocky extends Sprite 
	{
		public var pet : MovieClip ;
		private var _color : String = "red";
		private var _pos : Array ;
		private var _hasPet : Boolean = true;
		private var removeEffectClass : String = "RemoveEffect";
		private var effect : MovieClip ;
		
		public function Blocky()
		{
			pet.stop();
			pet.addFrameScript(1 , frameScript);
		}
		private function frameScript(): void
		{
			pet.stop();
		}
		public function get info() : Array
		{
			return [];
		}
		/**
		 * 数组中所处位置
		 */
		public function set pos(value: Array ) : void
		{
			_pos = value ;
		}
		public function get pos()  :Array
		{
			return _pos  as Array;
		}
		/**
		 * 颜色
		 */
		public function set color(value : String)  :void
		{
			_color = value ;
		}
		public function get color() : String 
		{
			return _color ;
		}
		/**
		 * 判断方块是否还有宠物
		 */
		public function get hasPet() : Boolean
		{
			return _hasPet ;
		}
		/**
		 * 删除头像
		 */
		public function removePet() : void
		{
			trace();
			if(pet != null && contains(pet)) removeChild(pet) ;
			_hasPet = false ;
		}
		/**
		 * 删除时候带有动画效果
		 */
		public function showEffect() : void
		{
			var effectName : Class = getDefinitionByName(removeEffectClass) as Class ;
			effect = new effectName() as MovieClip ;
			effect.addFrameScript(effect.totalFrames - 1 ,remove);
			effect.x = 24 ;
			effect.y = 26 ;
			addChild(effect);
		}
		
		private function remove() : void 
		{
			effect.stop();
			if(effect != null && contains(effect))removeChild(effect);
		}
	}
	
	
}
