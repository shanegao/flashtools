class com.qihoo.components.textAreaMix.ArrowButton extends MovieClip
{
	public static var ARROW_UP   : String = "up" ;
	public static var ARROW_DOWN : String = "down" ;
	public static var ARROW_LEFT : String = "left" ;
	public static var ARROW_RIGHT: String = "right" ;
	
	public var onMC : MovieClip ; 
	public var outMC: MovieClip ;
	
	public function ArrowButton()
	{
		init();
	}
	
	//
	private function init():Void
	{
		trace("init");
		this.useHandCursor = false ;
		onMC._visible  = false ;
		outMC._visible = true  ;	
	}
	//override the original Methods
	public function onRollOver():Void
	{
		onMC._visible  = true ;
		outMC._visible = false ;
	}
	public function onRollOut():Void
	{
		onMC._visible  = false ;
		outMC._visible = true  ;		
	}
	
	
	//setter and getter 
	[Inspectable(defaultValue = "right"; type = "String" ; enumeration = "up,down,left,right")]
	public function set buttonName(name:String):Void
	{
		var _angle:Number = 0 ; 
		switch(name)
		{
			case ArrowButton.ARROW_DOWN : 
				_angle = 0 ;
				break ;
			case ArrowButton.ARROW_LEFT :
				_angle = 90 ;
				break ;
			case ArrowButton.ARROW_UP :
				_angle = 180 ;
				break ;
			case ArrowButton.ARROW_RIGHT : 
				_angle = 270 ;
				break ;
			default : 
				_angle = 0 ;
		}
		setArrow(_angle);
	}
	private function setArrow(angle :Number):Void
	{
		if (isNaN(angle))
			angle = 0 ;
		outMC._rotation = onMC._rotation = angle ;
	}
	
}