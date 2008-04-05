/*
 * @author Gaoxian
 * @version FlvPlayer 1.0
 */
class DataPool {
	/*
	* 
	*/
	
	public static var NS : NetStream ;
	public static var SKIN:Skin ;
	public static var SO:Sound ;
	public static var NOW_VOLUME:Number ;
	
	public static var FIRST_CLICK_PLAY :Boolean = true;
	
	public static var SKIN_PATH:String = "skin/skin.swf" ;
	public static var VIDEO_PATH:String = "http://flashcoder.cn/video/beckham.flv" ;
	
	public static var STAGE_WIDTH:Number = 500 ; 
	public static var STAGE_HEIGHT:Number = 440 ;
	public static var BG_COLOR:Number = 0xFF3300 ;
	
	public static var FLV_DURATION:Number = 0;

	
	public static var loadingInterVal:Number ;
	public static var statusInterVal:Number ;
	public static var dragInterval:Number ;
	
	public function DataPool() {
		
	}
}