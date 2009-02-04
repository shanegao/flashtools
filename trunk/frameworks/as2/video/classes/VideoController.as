class code.video.classes.VideoController
{
	private var command : String;
	private var ns : NetStream ;
	//private var videoPath : String ;
	private var seekTime : Number = 0 ;

	public function VideoController(_command:String,_ns:NetStream,_time:Number)
	{
		ns = _ns ;
		//videoPath = _path ;
		command = _command ;
		seekTime = _time ;
	}
	
	public function doCommand()
	{
		/*
		if (command == "play")
		{
			playVideo(videoPath);
		}
		else
		*/ 
		if (command == "resume")
		{
			playVideo();
		}
		else if (command == "pause")
		{
			playVideo();
		}
		else if (command == "stop")
		{
			stopVideo();
		}
		else if (command == "seek")
		{
			seekVideo(seekTime);
		}
	}
	//
	private function playVideo():Void
	{
		ns.pause();
	}
	//stop the video player
	
	private function stopVideo():Void
	{
		ns.close();
	}
	
	//seek to the target time 
	private function seekVideo(_time:Number):Void
	{
		ns.seek(_time);
	}

}