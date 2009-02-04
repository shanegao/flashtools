package
{
	/*
	*@Author Gaoxian
	*@Version ActionScript 3.0 
	*@webSite www.flashcoder.cn
	*Set of funtions for handling color values in different format
	*/
	public class ColorUtils
	{
		public function ColorUtils(){}
		/*
		*@Param hex Number
		*°Ñ16½øÖƵÄColorֵת»»ΪObject¶ÔÏó
		*HexToRGB: returns the RGB (as Object) for the specified HEX value
		*/
		public static function HexToRGB(hex:Number):Object
		{
			return {r:hex >> 16, g:(hex >> 8) & 0xff, b:hex & 0xff};
		}
		/*
		*°Ñ r , g ,b ת»»Ϊ 16 ½øÖÆ×ַû´® Èç#FF0000 0xFF0000
		*  getHexStr: returns a string representing the HEX value 
		*  for the specified R,G,B values
		*/
		public static function getHexStr(
										  prefix:String,
										  r:Number,
										  g:Number,
										  b:Number 
													):String 
		{
			
			return  prefix 
					+ twoDigit(r.toString(16))
					+twoDigit(g.toString(16))
					+twoDigit(b.toString(16));
		}
		/*
		* getHex: returns the HEX value for the specified R,G,B values 
		*/
		public static function getHex(
										r:Number,
										g:Number,
										b:Number
												):Number
		{
			return r << 16 | g << 8 | b;
		}
		/*
		*	twoDigit: adds "0" in front if the string is only
	  	* 	one digit also useful for converting date time strings 
		*/
		public static function twoDigit(str:String):String
		{
			return str.length == 1 ? ("0" + str) : str ;
		
		}
	}
}