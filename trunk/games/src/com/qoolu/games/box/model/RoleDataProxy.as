package com.qoolu.games.box.model 
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.interfaces.IProxy;
	
	/**
	 * 角色数据
	 * @author Gaoxian
	 */
	public class RoleDataProxy extends Proxy implements IProxy 
	{
		public static const NAME : String = "RoleDataProxy";
		
		private var roleArray : Array ;
		
		private var RED : String = "RedRole";
		private var BLUE : String = "BlueRole";
		private var DEEP_BLUE : String = "DeepBlueRole" ;
		private var YELLOW  : String = "YellowRole" ;
		private var GREEN : String = "GreenRole";
		private var PURPLE : String = "PurpleRole" ;
		private var PINK : String = "PinkRole";
		private var GREY : String = "GreyRole";
		
		public function RoleDataProxy () 
		{
			super(NAME);
			roleArray = [RED , BLUE, DEEP_BLUE , YELLOW , GREEN , PURPLE ,PINK , GREY];
		}
		/**
		 * 得到当前级别的角色个数
		 */
		public function rolesInCurrentLevel () : Array
		{
			var arr : Array =[] ;
			var levelData : LevelDataProxy = new LevelDataProxy() ; 
			var num :int = levelData.numOfRole();
			arr = fetchUniqItem(roleArray, num);
			return arr ;
		} 
		/**
		 * 在目标数组中，取出指定个数不重复索引的元素。。。。
		 * @param src 目标数组 
		 * @param num 要得到的元素个数
		 */
		private function fetchUniqItem(src :Array , num : int) : Array
		{
			var arr : Array = [] ;
			for(var i :int = 0 ; i <num ; i++)
			{
				var index : int = Math.floor(Math.random() * src.length) ;
				arr.push(src[index]);
				src.slice(index,1);
			}
			
			return arr ;
		}
	}
}
