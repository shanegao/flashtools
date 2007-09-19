
//******************************************
//	123 Flash Chat Software
//	Copyright (c) 2006 TopCMM SOFTWARE
//******************************************
/** 
 * @author		Tim
 * @version		123flashchat 7.0, ActionScript 2.0, FlashPlayer 8.0
 */
class Log {

	public static function init():Void{}
	
	/**
	 * this is the "trace" method when compiled with MTASC
	 * work with the debugPanel.swf module
	 * 
	 * @author		Tim
	 * @param		txt:String, trace text.
	 * @param		className:String, the class name package name.
	 * @param		file:String, the file name.
	 * @param		num:Number, the code line number.
	 */
	public static function debugMsg(txt:String, className:String, file:String, num:Number):Void{
		var debugConn:LocalConnection = new LocalConnection();
		debugConn.send("showLogInDebugPanel", "addMsg", txt, className, file, num);
	}
}