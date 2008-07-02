package com.qoolu.games.box.model 
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.interfaces.IProxy;
	
	/**
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
		
		public function rolesInCurrentLevel () : Array
		{
			var arr : Array =[] ;
			var levelData : LevelDataProxy = new LevelDataProxy() ; 
			levelData.numOfRole();
			
			return arr ;
		} 
	}
}
