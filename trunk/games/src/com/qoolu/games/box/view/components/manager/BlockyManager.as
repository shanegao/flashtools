package com.qoolu.games.box.view.components.manager {
	import flash.utils.getDefinitionByName;
	
	import com.qoolu.games.box.view.components.blockys.Blocky;		

	/**
	 * @author Gaoxian
	 */
	public class BlockyManager 
	{
		public static const  packagePath : String = "com.qoolu.games.box.view.components.blockys.";
		
		public static function createBlocky(classNameStr : String) : Blocky 
		{
			var className : Class = getDefinitionByName(packagePath	+ classNameStr) as  Class ; 
			return new className() as Blocky ;
		}
	}
}
