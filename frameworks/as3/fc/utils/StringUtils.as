﻿package fc.utils 
{
	import fc.errors.Errors;
	
	
	/**
	 * @author GaoXian
	 */
	public class StringUtils 
	{
		/**
		 * @param minisecond
		 */
		public static function formatTime(minisecond : Number) : String
		{
			if (minisecond >= 0)
			{
				//var d : Number = Math.floor(minisecond/60/60/24);
				//minisecond %= 60*60*24;
				//var h : Number = Math.floor(minisecond/60/60);
				//minisecond %= 60*60;
				var m :Number = Math.floor(minisecond/60);
				var s : Number = minisecond%60;
				return digiNumber(m , 2) + ":" + digiNumber(s ,2 );
			}
			return Errors.paramIsInvalid ;
		}
		/**
		 *转换
		 */	
		public static function digiNumber(num:Number , len : int):String 
		{
			return String(num).length < len?"0" + String(num):String(num);
		}
		
		/**
		 * 替换字符串中的一些子字符串
		 * @author adobe
		 */
		public static function replace(input:String, replace:String, replaceWith:String):String
		{
			//change to StringBuilder
			var sb:String = new String();
			var found:Boolean = false;

			var sLen:Number = input.length;
			var rLen:Number = replace.length;

			for (var i:Number = 0; i < sLen; i++)
			{
				if(input.charAt(i) == replace.charAt(0))
				{   
					found = true;
					for(var j:Number = 0; j < rLen; j++)
					{
						if(!(input.charAt(i + j) == replace.charAt(j)))
						{
							found = false;
							break;
						}
					}

					if(found)
					{
						sb += replaceWith;
						i = i + (rLen - 1);
						continue;
					}
				}
				sb += input.charAt(i);
			}
			//TODO : if the string is not found, should we return the original
			//string?
			return sb;
		}
	}
}
