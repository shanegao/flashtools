import flash.geom.ColorTransform;
import flash.geom.Transform;
class com.components.loading.Loading extends MovieClip
{
	public var loading : MovieClip ;
	public var loadingBG  :MovieClip ;
	private var _lp  :Number ;
	private var _show : Boolean = true ;
	private var _textInfo:String = "loaded"; 
	private var _foreColor:Number = 0xFFFFFF;
	private var _bgColor : Number = 0x000000 ;
	private var _colorObj:Object  ;
	
	public function Loading()
	{
		initLoading();
		//trace("loading");
	}
	private function initLoading():Void
	{
		loading._width = 0 ;
	
	}
	
	[Inspectable(defaultValue = 0 ; type = "Number" )]
	public function set loadPrecent(_num :Number):Void
	{
		if(isNaN(_num) || _num < 0)
			_num = 0 ;
		else if (_num > 100)
			_num = 100 ;
		_lp = _num ;
		
		update();
		
		if (_show)
			showTextInfo();
		else
			removeTextInfo();
	}
	public function get loadPrecent():Number
	{
		return _lp ;
	}
	
	[Inspectable(defaultValue=true	;	type="Boolean")]
	public function set showText(_b:Boolean):Void
	{
		if (_b == null) 
			_b = false ;
		_show = _b ; 
		if (_show)
			showTextInfo();
		else
			removeTextInfo();
	}
	
	public function get showText():Boolean
	{
		return _show  ;
	}
	
	[Inspectable(defaultValue = "loaded"; type = "String" )]
	public function set textInfo(str:String):Void
	{
		if (_textInfo == null )
			_textInfo = "loaded "; 
		_textInfo = str;
	}
	
	public function get textInfo():String
	{
		return _textInfo  ;
	}
	//
	[Inspectable(defaultValue="#FF0000" ; type="Color" )]
	public function set foreColor(col:Number):Void
	{
			if (isNaN(col))
				col = 0xFF0000 ;
			_foreColor = col ;
			setColor(loading , _foreColor );
	}
	public function get foreColor():Number
	{
		return _foreColor ;
	}
	
	[Inspectable(defaultValue="#000000" ; type="Color" )]
	public function set bgColor(col:Number):Void
	{
			if (isNaN(col))
				col = 0x000000 ;
			_bgColor = col ;
			setColor(loadingBG , _bgColor);
	}
	public function get bgColor():Number
	{
		return _bgColor ;
	}
	//[Inspectable(defaultValue = "foreColor:0xFFFFFF,bgColor:0x000000" ; type = "Object" )]
	public function set color(obj:Object):Void
	{
		trace("obj.foreColor : " + obj.bgColor);
		_colorObj = obj ;
		_foreColor = _colorObj.foreColor ;
		_bgColor = _colorObj.bgColor ;
		if (isNaN(_foreColor))
		{
			_foreColor = 0xFF0000 ;
		}
		if (isNaN(_bgColor))
		{
			_bgColor = 0x000000 ;
		}
	
		setColor(loadingBG , _bgColor);
	}
	
	public function get color():Object
	{
		return _colorObj  ;
	}
	//
	/*
	[Inspectable(defaultValue=100 ; type="Number" )]
	public function set width(_w:Number):Void
	{
		if (isNaN(_w))
			_w = 0 ;
		_width = _w ;	
		loadingBG._width = _w ;
		update();
	}
	public function get width():Number
	{
		return _width ;
	}
	[Inspectable(defaultValue=12 ; type="Number" )]
	public function set height(_h:Number):Void
	{
		if (isNaN(_h))
			_h = 0 ;
		_height = _h ;
		loadingBG._height = _h ;
		loading._height   = _h -2;
	}
	
	public function get height() :Number
	{
		return _height ;
	}
	*/
	//show the TEXT infomation 
	public function showTextInfo():Void
	{
		var txt:TextField = this.createTextField("info", 10, 0, 0, 100, 200) ;
		txt.text  = _textInfo + _lp.toString() + "%";
		txt.autoSize = true ;
		txt._x = loading._width - txt._width *.5  ;
		txt._y = -20 ;
	}
	//remove the TEXT infomation
	public function removeTextInfo():Void
	{
		if (this["info"] != null)
			this["info"].removeTextField();
	}
	private function update():Void
	{
		loading._width = _lp * loadingBG._width *.01 - 2;
	}
	private function setColor(mc:MovieClip , col:Number) :Void
	{
		if (mc == null || col == null) 
			return ;
		var ctrans:ColorTransform = new ColorTransform();
		ctrans.rgb = col ;
		var trans:Transform = new Transform(mc);
		trans.colorTransform = ctrans ;
	}
	

}