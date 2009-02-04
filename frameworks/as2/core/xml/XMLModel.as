import mx.events.EventDispatcher;
/* 
 *@author Gaoxian
 *@convert xml to object 
 */
com.core.xml.XMLLoader extends XML
{
	
	private var xmlConfig  :String;
	
	//
	public var addEventListener    :Function;
	public var removeEventListener :Function;
	private var dispatchEvent      :Function;
	
	//
	public function XMLModel(_xml)
	{
		super();
		
		EventDispatcher.initialize(this) ;
	}
	
	public function 
}