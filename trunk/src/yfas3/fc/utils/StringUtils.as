package fc.utils 
{
	
	/**
	 * @author GaoXian
	 */
	public class StringUtils 
	{
		/**
		 * 替换字符串中的一些子字符串
		 * @author adobe
		 */
		function formatTime(minitime : Number) : String
		{
			if (minitime >= 0)
			{
				var d : Number = Math.floor(offsetTime/60/60/24);
				offsetTime %= 60*60*24;
				var h : Number = Math.floor(offsetTime/60/60);
				offsetTime %= 60*60;
				var m :Number = Math.floor(offsetTime/60);
				var s : Number = offsetTime%60;
			}
		}
		/**
		 *转换
		 */	
		function digiNumber(num:Number):String 
		{
			return String(num).length < 2?"0" + String(num):String(num);
		}
		
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
