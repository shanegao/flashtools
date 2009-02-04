//
import code.video.classes.VideoController ;
class code.video.classes.VideoPlayer
{
	private var video:Video ;
	private var nc:NetConnection ;
	private var ns:NetStream ;
	private var volume:Sound ;
	
	//
	public var totalTime : Number = 0 ;
	public var videoPath : String = "";
	public var bufferTime :Number = 0 ;
	public var seekTime : Number = 0 ;
	//
	private var bufferTimeOffset : Number = 15 ;
	private var isBuffering :Boolean = false ; 
	//
	
	public function VideoPlayer(_video:Video)
	{
		video = _video ;
		init();
	}
	//
	private function init():Void
	{
		//_root.createTextField("aaa", 1, 0, 0, 100,100);
		//_root.aaa.text = "aaaaa" ;
		//
		//initN();
		//videoControl("play");
	}
	//
	private function initN():Void
	{
		nc = new NetConnection();
		nc.connect(null);
		ns = new NetStream(nc);
		video.attachVideo(ns);
	}
	public function set videoVolume(_volume:Number):Void
	{
		var volumeMC:MovieClip = _root.createEmptyMovieClip("volumeMC", -109876);
		volumeMC.attachAudio(ns);
		volume = new Sound(volumeMC);
		volume.setVolume(_volume);
	}
	
	/*
	  * @param _command : String
	  * - play    the first time to play the video
	  * - resume  
	  * - pause 
	  * - stop
	  * - seek    seek to the "seekTime"
	 */
	
	public function videoControl(_command:String):Void
	{
		trace("videoControl.command " + _command );
		var owner:Object = this ;
		if (_command == "play")
		{
			initN();
			if (totalTime == 0)
			{
				checkTheTotalTime();
			}
			ns.onStatus = owner.checkTheNsStatus();
			startPlayVideo();
		}
		else
		{
			var vc:VideoController = new VideoController(_command , ns , seekTime);
			vc.doCommand();
		}
	}
	//check the total time is already defined , if done, do nothings ,
	//and if not , try to get it from the ns.onMetaData
	private function checkTheTotalTime():Void
	{
		if (totalTime == 0)
		{
			var owner:Object = this ;
			
			ns.onMetaData = function(initObj:Object)
			{
				owner.totalTime = initObj.duration ; 
			}
		}	
	}
	private function checkTheNsStatus(infoObj:Object):Void
	{
		switch(infoObj.code)
		{
			case "NetStream.Play.StreamNotFound" :
				trace("NetStream.Play.StreamNotFound");
				break;
		}
	}	
	//
	private function startPlayVideo():Void
	{
		ns.play(videoPath);
		
		trace("video path : startPlayVideo");
	}
	//
	public function get loadingInfo():Number
	{
		var precent:Number = Math.round(ns.bytesLoaded / ns.bytesTotal * 100);
		precent = isNaN(precent) ? 0 : precent ;
		if (precent >= 100)
			onLoadComplete();
		return precent ;
	}
	//the precent of playing the video
	public function get playingInfo():Number
	{
		var precent:Number = Math.round(ns.time / totalTime * 100) ;
		precent = isNaN(precent) ? 0 : precent ;
		if (precent >= 100)
			onPlayComplete();
		return precent;
	}
	//check buffer
	public function checkBuffer():Boolean
	{
		trace("ns.bufferTime : " + ns.bufferTime);
		trace("ns.bufferLength : " + ns.bufferLength);
		trace("isBuffering : " + isBuffering );
		trace("ns.bufferTime - ns.bufferLength > bufferTimeOffset : " + (ns.bufferTime - ns.bufferLength > bufferTimeOffset));
		if (ns.bufferTime - ns.bufferLength > bufferTimeOffset && !isBuffering)
		{
			isBuffering = true ;
			videoControl("pause");
		}
		else if (ns.bufferTime - ns.bufferLength < bufferTimeOffset && isBuffering)
		{
			isBuffering = false ;
			videoControl("resume");
		}
		return isBuffering ;
	}
	
	//for implementing in the external class 
	public function onLoadComplete():Void
	{
		trace("load complete!");
	}
	public function onPlayComplete():Void
	{
		trace("play complete!");
	}
	/*
	 * @param time second
	 */
	public function set _totalTime(_time : Number):Void
	{
		totalTime = _time ;
	}
	public function get _totalTime():Number
	{
		return totalTime ;
	}
	
	/*
	 * @param time second
	 */
	public function set _bufferTime(_time:Number):Void
	{
		//
		ns.setBufferTime(_time);
		bufferTime = _time ;
	}
	public function get _bufferTime():Number
	{
		return bufferTime ;
	}
	/*
	 * @param path 
	 */
	public function set _videoPath(_path:String):Void
	{
		videoControl("close");
		videoPath = _path ;
		videoControl("play");
	}
	public function get _videoPath():String
	{
		return videoPath ;
	}
	
	public function set _seekTime(_time:Number):Void
	{
		if (_time <= totalTime && _time >= 0)
		{
			seekTime = _time ;
			videoControl("seek", _time);
		}
	}
	public function get _seekTime():Number
	{
		return seekTime  ;
	}
	/*
	* MTASC enter 
	*/
	public static function main():Void
	{
		var a:VideoPlayer = new VideoPlayer();
	}
}