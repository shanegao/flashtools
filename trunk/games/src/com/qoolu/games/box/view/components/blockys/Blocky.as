package com.qoolu.games.box.view.components.blockys {
	import flash.display.MovieClip;	
	import flash.display.Sprite;
	
	
	/**
	 * @author Gaoxian
	 * 方块基类
	 */
	 
	public class Blocky extends Sprite 
	{
		public var pet : MovieClip ;
		private var _color : String = "red";
		private var _pos : Array ;
		
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
		public function hasPet() : Boolean
		{
			return pet != null ;
		}
		/**
		 * 删除头像
		 */
		public function removePet() : void
		{
			if(pet != null && contains(pet)) removeChild(pet) ;
		}
	}
	
	
}
