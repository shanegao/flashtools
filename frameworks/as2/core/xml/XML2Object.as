/**
* ...
* @author Gaoxian
* @version 0.1
*/

class code.core.xml.XML2Object {

	public function XML2Object() 
	{
		
	}
	public static function build(n:XML):Object
	{
		var o = new String(n.firstChild.nodeValue), s, i, t;
		//trace(o)
		for (s = (o == "null") ? n.firstChild : n.childNodes[1]; s != null; s = s.nextSibling) 
		{
			t = s.childNodes.length>0 ? build(s) : new String(s.nodeValue);
			for (i in s.attributes) 
			{
				t[i] = s.attributes[i];
			}

			if (o[s.nodeName] != undefined) 
			{
				if (!(o[s.nodeName] instanceof Array)) 
				{
					o[s.nodeName] = [o[s.nodeName]];
				}
				o[s.nodeName].push(t);
			} 
			else 
			{
				o[s.nodeName] = t;
			}
		}
	
		var data = o;
		return data;
	}
	

}