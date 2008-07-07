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
		
		public function get info() : Array
		{
			return [];
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
