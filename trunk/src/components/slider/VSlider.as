import mx.events.EventDispatcher;
import mx.utils.Delegate;
class VSlider extends MovieClip
{
	private var dragBar : MovieClip ;
	private var scopeMC : MovieClip ;
	
	
	private var addEventListener : Function ;
	private var removeEventListener : Function ;
	private var dispatchEvent:Function;
	
	private var dragInterval : Number = 0 ;
	public static var ON_SLIDER:String = "slider";
	
	[IconFile("hslider.png")]

	public function VSlider()
	{
		super();
		EventDispatcher.initialize(this);
		init();
	}
	//init 
	private function init():Void
	{
		//
		
		//trace("init") ;
		initDragBar();
		initScope();
	}
	//
	private function initDragBar():Void
	{
		var  owner : Object = this ;
		dragBar._x = dragBar._y = 0 ;
		
		dragBar.onPress = function():Void
		{
			this.startDrag(true,0,0,0,Math.round(owner.scopeMC._height));
			//trace(" scopeMC._width : " + owner.scopeMC._width);
			//this.startDrag(true,0,0,100,0);
			owner.dragInterval = setInterval(owner.onDrag , 100 , owner);
		};
		dragBar.onRelease = dragBar.onReleaseOutside = function():Void
		{
			this.stopDrag();
			clearInterval(owner.dragInterval);
		};
		
	}
	
	//
	private function initScope():Void
	{
		scopeMC._x = -7 ;
		scopeMC._y = 0 ;
	}
	//
	private function onDrag(owner:Object):Void
	{
		var num:Number = Math.round(owner.dragBar._y / owner.scopeMC._height * (owner._max - owner._min));
		num += owner._min ;
		owner.dispatchEvent({type:HSlider.ON_SLIDER , target:owner,data:num});
	};
	
	
	private var _min:Number = 0 ;
	private var _max:Number = 100 ;
	
	[Inspectable(type="Number", defaultValue=0)]
	public function set min(_num:Number):Void
	{
		_num = Math.round( _num );
		_min = _num ;
	}
	public function get min():Number
	{
		return _min  ;
	}
	[Inspectable(type="Number", defaultValue=100)]
	public function set max(_num:Number):Void
	{
		_num = Math.round( _num );
		_max = _num ;
	}
	public function get max():Number
	{
		return _max  ;
	}	
}