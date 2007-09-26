/**
 * @author Gaoxian
 * @version ActionScript 2.0
 */
class Swfit {
	/*
	* 一些常用的方法
	*/
	
	
	/**
	 *@param mc:MovieClip 要绘制矩形的mc
	 *@param col:Number 颜色值
	 *@param width:Number 宽
	 *@param height:Number 长
	 */
	public static function drawRect(mc:MovieClip,col:Number,width:Number,height:Number):Void
	{
		mc.beginFill(col,100);
		mc.moveTo(0,0);
		mc.lineTo(0,height);
		mc.lineTo(width,height);
		mc.lineTo(width ,0);
		mc.lineTo(0,0);
		mc.endFill();
	}
	
	public static function formatTime(second:Number):String
	{
    	var minutes:Number = Math.floor(second/60);
    	var seconds:Number = Math.floor(second%60);
    	var secondStr:String = "";
   		if (seconds<10) 
   		{
   	 		secondStr = "0"+seconds;
    	}
    	else
    	{	
    		secondStr = seconds.toString();
    	}
		return minutes.toString() +":"+ secondStr ;
	}
}