package com.qoolu.games.box.view.components.manager {
	import flash.utils.getDefinitionByName;
	
	import com.qoolu.games.box.view.components.blockys.Blocky;		

	/**
	 * @author Gaoxian
	 */
	public class BlockyManager 
	{
		public static const  packagePath : String = "com.qoolu.games.box.view.components.blockys.";
		/**
		 * 创建方块
		 */
		public static function createBlocky(classNameStr : String) : Blocky 
		{
			var className : Class = getDefinitionByName(packagePath	+ classNameStr) as  Class ; 
			return new className() as Blocky ;
		}
		/**
		 * 复制出一个新的方块
		 */
		public static function copyBlocky(allClass : Array , target :Blocky) : Blocky
		{
			trace("copyBlocky " ,allClass,target.name);
			var classStr : String = String(allClass[Math.floor(Math.random() * allClass.length)]) ;
			var className : Class = getDefinitionByName(packagePath	+ classStr) as  Class ; 
			var newBlocky : Blocky = new className() as Blocky;
			if(!target.hasPet) newBlocky.removePet();
			trace("target.hasPet() : " + target.hasPet);
			newBlocky.x = target.x;
			newBlocky.y = target.y ; 
			newBlocky.width = target.width ;
			newBlocky.height = target.height ;
			newBlocky.pos = target.pos ;
			newBlocky.name = target.name ;
			target.parent.addChild(newBlocky);
			if(target.parent != null) target.parent.removeChild(target);
			return newBlocky;
		}
	}
}
