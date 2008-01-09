import mx.events.EventDispatcher ;
import mx.utils.Delegate ;
import com.core.events.LoadEvent ;
/**
* ...
* convert xml to object 
* @author GaoXian
* @version 0.1
* xml.getBytesTotal()不能很快的得到应有的值..
* 所以不能很精确的得到
* */
//events
[Event("onLoadStart")]
[Event("onLoadComplete")]
[Event("onLoadPregress")]
[Event("onLoadError")]

class com.core.xml.XMLLoader 
{
	
	private var xmlPath  :String;
	
	private var xml      :XML ;
	//
	public var addEventListener    :Function;
	public var removeEventListener :Function;
	private var dispatchEvent      :Function;
	
	var loadInterval : Number = 0 ;
	var isStart      : Boolean = false;
	private var loadComplete : Boolean = false ;
	//
	public function XMLLoader(_path:String)
	{
		if (_path == null || _path == "" )
		{
			trace("the xml path can not be null or empty");
		}
		else
		{
			EventDispatcher.initialize(this) ;
			xmlPath = _path ; 
			loadXML();
		}
	}
	
	private function loadXML()
	{
		xml = new XML();
		xml.ignoreWhite = true ;
		xml.onLoad = Delegate.create(this,onXMLLoad) ;
		xml.load(xmlPath);
		var interval  :Number = 10 ;
		loadInterval = setInterval(Delegate.create(this,loading),interval);
	}
	
	private function loading():Void
	{
		var bl :Number = xml.getBytesLoaded() ;
		var bt :Number = xml.getBytesTotal() ;
		
		//trace("loading  " + [bl, bt]);
		if(bt != undefined && !isStart)
		{
			_dispatchEvent(LoadEvent.LOAD_START) ;
			isStart = true ;
		}
		if (bl > 0)
		{
			var precent :Number = Math.floor( bl / bt * 100) ;
			precent = precent == Number.POSITIVE_INFINITY ? 0 : precent ;
			trace("precent : " + precent);
			//_dispatchEvent(LoadEvent.LOAD_PREGRESS) ;
			dispatchEvent( { type:LoadEvent.LOAD_PREGRESS,target:xml,loaded:precent} );
			if(precent >= 0 && loadComplete)
			{
				_dispatchEvent(LoadEvent.LOAD_COMPELET) ;
				clear();
			}
		}
	}
	//
	private function onXMLLoad(suc:Boolean):Void
	{
		loadComplete = suc ;
		if(!suc)
		{
			_dispatchEvent(LoadEvent.LOAD_ERROR) ;
			clear();
		}
	}
	//
	public function onXMLData(src:String) :Void
	{
		if (src == undefined)
		{
			_dispatchEvent(LoadEvent.LOAD_ERROR) ;
		}
		else
		{
			_dispatchEvent(LoadEvent.LOAD_COMPELET,new XML(src)) ;
		}
		clear();
	}
	
	//clear the Interval ID
	private function clear():Void
	{
		clearInterval(loadInterval) ;
	}
	
	//dispath the Event 
	private function _dispatchEvent(type:String):Void
	{
		var event:Object = { };
		event.type   = type ;
		event.target = xml ;
		dispatchEvent(event);
	}
}

/*
		//test code 
		import com.core.xml.* ;
		import com.core.events.* ;
		import mx.utils.Delegate;

		var xmlPath:String = "http://flashcoder.cn/blog/?feed=rss2" ;
		var xmlLoader  :XMLLoader = new XMLLoader(xmlPath);

		xmlLoader.addEventListener(LoadEvent.LOAD_START,Delegate.create(this,onStart));
		xmlLoader.addEventListener(LoadEvent.LOAD_ERROR,Delegate.create(this,onError));
		xmlLoader.addEventListener(LoadEvent.LOAD_PREGRESS,Delegate.create(this,onPregress));
		xmlLoader.addEventListener(LoadEvent.LOAD_COMPELET,Delegate.create(this,onComplete));

		function onStart(evt:Object):Void
		{
			trace("start");
		}
		function onComplete(evt:Object):Void
		{
			trace("complete");
			//trace(evt.target);
		}
		function onError(evt:Object):Void
		{
			trace("error");
		}
		function onPregress(evt:Object):Void
		{
			trace("progress" + evt.loaded)
			l.loadPrecent = evt.loaded ;
		}
 */
		