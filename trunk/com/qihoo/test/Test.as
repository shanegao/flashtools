class com.qihoo.test.Test
{
	public function Test()
	{
		_root.createTextField("txt",0,10,12,11,45) ; 
		_root.txt.text = "aaaa" ;
		_root.txt.autoSize = true ;
		
		/* test SharedObject  */
		var so:SharedObject = SharedObject.getLocal("nama", "/");
		if (so.data.name == null )
		{
			so.data.name = "gx" ;
		} 
		else 
		{
			trace(so.data.name);
		}
	}
	//MATSC entry 
	//public function main()
	//{
		//var a :Test = new Test();
	//}
}