package
{
	/*
	*@Author yufei
	*@Version ActionScript 3.0 
	*@webSite www.flashcoder.cn
	*  getWords returns Array of words and non words from a string 
	*/
	public class StringUtils
	{
		public function StringUtils(){}
		/*
		* gets the words in to array elements
		*/
		public static function getWords(str:String):Array
		{
			var arr:Array = new Array();
			var lastIndex:Number = 0;
			for (var i:Number = 0 ; i < str.length ; i++)
			{
				var code:Number = str.charCodeAt(i);
				var char:String = str.charAt(i);
				if (isWord(code)) 
				{
					//trace(" '"+char+"' "+"isWord");
				} 
				else 
				{
					//trace(" '"+char+"' "+"is Not Word");
					var word:String = str.substring(lastIndex, i);
					if (word == '')
					{
					/* 
				  	 empty string that means
				  	 we have 2 or more non word chars together
				  	 so add them together
					*/
						if (arr.length != 0) 
						{
							arr[arr.length-1] = arr[arr.length-1]+char;
						}
						else
						{
							arr.push('');
							arr.push(char);
						}
					}
					else 
					{
						arr.push(word);
						arr.push(char);
					}
					lastIndex = i+1;
				}
			}
			if (lastIndex != str.length) 
			{
			//last char is not a non-word so add the lost word to list
				word = str.substring(lastIndex, str.length);
				arr.push(word);
				arr.push('');
			}
			trace(arr.length);
			return arr;
		}
		/* 
		   Charcode range for non word chars
		   9,10,13
		   32 to 47
		   58 to 64
		   91 to 96
		   123 to 126
	 	*/
	 	public static function isWord(char:Number):Boolean
	 	{
	 		if (char == 10 
	 				|| char == 9 
	 					|| char == 13 
	 						|| (char >= 32 && char <= 44) 
	 							|| (char >= 46 && char <= 47) 
	 								|| (char >= 58 && char <= 64)
	 									 || (char >= 91 && char <= 96)
	 									 	 || (char >=123 && char <= 126))
	 		{
				return false;
			} 
			else 
			{
				return true;
			}

	 	}
		/*
		*HTML Encodes the char
		*/
		public static function htmlEncode(chr:String):String
		{
			switch (chr)
			{
				case ' ' :
					chr = " ";
					break;
				case '<' :
					chr = "&lt;";
					break;
				case '>' :
					chr = "&gt;";
					break;
				case '&' :
					chr = "&amp;";
					break;
				case '\"' :
					chr = "&quot;";
					break;
				case "'" :
					chr = "&apos;";
					break;
			}
			return chr;
		}
	}
}