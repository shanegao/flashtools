import mx.utils.Delegate;

/**
 * @author Gaoxian
 * @version ActionScript 2.0
 */
class FlvPlayer {
	private var inBuffering:Boolean = false ;
	private var OFFSET:Number = 10 ;
	private var nc:NetConnection ;
	public function FlvPlayer(){
		//Test Code start
		trace("FlvPlayer");
		//Test code end
		init();
		
	}
	public function init():Void{
		trace("init runing");
		var sl:StageListener = new StageListener();
		var _this:Object = this;
		sl.onResize = function():Void{
			_this.resize();
		};

		nc = new NetConnection();
		nc.connect(null);

		DataPool.NS = new NetStream(nc);

		DataPool.NS.setBufferTime(30);
		DataPool.SKIN = new Skin();

		//Add Event Listener..
		DataPool.SKIN.addEventListener(Skin.SKIN_COMPLETE,Delegate.create(this,onSkinComplete));
	}
		/*
	 * MATSC compiler 入口
	*
	*/
	public static function main(container : MovieClip) : Void {
		//debug code
		Log.debugMsg("aaaaaaaa");
		//
		var fp:FlvPlayer = new FlvPlayer();
	}
	
	private function resize():Void{
		trace([DataPool.STAGE_HEIGHT,DataPool.STAGE_WIDTH].toString());
		
		var myVideo:Video = DataPool.SKIN.videoMC.theVideo;
		DataPool.SKIN.bgMC._width = DataPool.STAGE_WIDTH ;
		DataPool.SKIN.bgMC._height = DataPool.STAGE_HEIGHT ;
		myVideo._width = DataPool.STAGE_WIDTH - 2*OFFSET ; 
		myVideo._height = DataPool.STAGE_HEIGHT - 5*OFFSET ;
		center(DataPool.SKIN.controlBar,false);
		center(DataPool.SKIN.pauseIcon,true);
		center(DataPool.SKIN.playIcon,true);
		//mySkin.controlBar._width = DataPool.STAGE_WIDTH - 4*OFFSET ;
	}
	//Event Handler..
	private function onSkinComplete(evt:Object):Void{
		var _this:Object = this;		
		trace("onSkinComplete");
		var myVideo:Video = DataPool.SKIN.videoMC.theVideo;
		
		
		myVideo._x = myVideo._y = OFFSET ; 
		myVideo._width = DataPool.STAGE_WIDTH - 2*OFFSET ; 
		myVideo._height = DataPool.STAGE_HEIGHT - 5*OFFSET ;
		
		DataPool.SKIN.playIcon._visible = true;
				
		
		center(DataPool.SKIN.controlBar,false);
		center(DataPool.SKIN.pauseIcon,true);
		center(DataPool.SKIN.playIcon,true);
		
		//
		DataPool.SKIN.addEventListener(Skin.CKICK_VIDEO , Delegate.create(this,onClickVideo));
		DataPool.SKIN.addEventListener(Skin.DOUBLE_CLICK_VIDEO , Delegate.create(this,fullScreen));
		DataPool.SKIN.addEventListener(Skin.START_PLAY , Delegate.create(this,startPlay));
		DataPool.SKIN.addEventListener(Skin.PAUSE , Delegate.create(this,pause));
		
		DataPool.SKIN.addEventListener(Skin.CLICK_FULLSCREEN_BUTTON , Delegate.create(this,fullScreen));
		
		DataPool.SKIN.addEventListener(Skin.START_DRAG , Delegate.create(this,onStargDrag));
		DataPool.SKIN.addEventListener(Skin.STOP_DRAG , Delegate.create(this,onStopDrag));
		DataPool.SKIN.addEventListener(Skin.STOP_FLV_PLAY , Delegate.create(this,onStopFlv));
		
		DataPool.SKIN.addEventListener(Skin.CLICK_SOUND_BUTTON , Delegate.create(this,isSound));
		
		DataPool.SKIN.addEventListener(Skin.CLICK_SOUND_CONTROL , Delegate.create(this,soundControl));
		
	}
	

	private function setEvent():Void{
	
		DataPool.loadingInterVal = setInterval(loadingFlv,1000);
		DataPool.statusInterVal = setInterval(playingFlv,1000);
	}
	//点击Play按钮
	private function startPlay(evt:Object):Void{
		trace("Start   Play..........");
		//
		var _this:Object = this ;
		DataPool.SKIN.pauseBtn._visible = !DataPool.SKIN.pauseBtn._visible;
		DataPool.SKIN.playBtn._visible = !DataPool.SKIN.playBtn._visible;
		DataPool.SKIN.playIcon._visible = !DataPool.SKIN.playIcon._visible ;
		//video
		DataPool.SKIN.videoMC.theVideo.attachVideo(DataPool.NS);
		DataPool.NS.play(DataPool.VIDEO_PATH);
		DataPool.NS.onMetaData = function(info:Object):Void
		{
			//trace(info.duration.toSting());
			trace(info["duration"].toString()) ;
			DataPool.FLV_DURATION = info["duration"] ;
			
		};

		//sound
		DataPool.SKIN.soundAsset.attachAudio(DataPool.NS);
		DataPool.SO = new Sound(DataPool.SKIN.soundAsset);
		DataPool.NOW_VOLUME = DataPool.SO.getVolume();
		
		setEvent();
		/*
		DataPool.NS.setBufferTime(30);
		DataPool.NS.onStatus = function(info:Object):Void{
 			trace(info.code);
			
			if(info.code == "NetStream.Buffer.Full"){
		
				_this.pause();
			
			}
			if(info.code == "NetStream.Buffer.Empty"){
		
				_this.pause();
			}
			
			if(info.code == "NetStream.Play.Stop"){
	
				this.seek(0);
			}
			if(info.code == "NetStream.Play.StreamNotFound"){
				}
		};
		
		 * 
		 */
	}
	//pause
	private function pause(evt:Object):Void
	{
		DataPool.SKIN.pauseBtn._visible = !DataPool.SKIN.pauseBtn._visible;
		DataPool.SKIN.playBtn._visible = !DataPool.SKIN.playBtn._visible;
		DataPool.SKIN.pauseIcon._visible = !DataPool.SKIN.pauseIcon._visible ;
		DataPool.NS.pause();

	}
	private function onStargDrag(evt:Object):Void
	{
		DataPool.dragInterval = setInterval(dragFlv,100);
		clearInterval(DataPool.statusInterVal);
	}
	private function onStopDrag(evt:Object):Void
	{
		clearInterval(DataPool.dragInterval);
		DataPool.statusInterVal = setInterval(playingFlv,1000);
	}

	private function onStopFlv(evt:Object):Void
	{
		DataPool.NS.close();
		DataPool.NS.seek(0);
		DataPool.SKIN.pauseBtn._visible = false;
		DataPool.SKIN.playBtn._visible = true;
		DataPool.SKIN.pauseIcon._visible = false ;
		DataPool.SKIN.playIcon._visible = true ;
		
		clearInterval(DataPool.loadingInterVal);
		clearInterval(DataPool.statusInterVal);
	}

	private function isSound(evt:Object):Void
	{
		if(DataPool.SO.getVolume() != 0)
		{
			DataPool.SO.setVolume(0);
			evt.target.iconMC._visible = true;
		}
		else
		{
			DataPool.SO.setVolume(DataPool.NOW_VOLUME);
			evt.target.iconMC._visible = false;
		}
		trace(DataPool.NOW_VOLUME.toString());
	}
	private function soundControl(evt:Object):Void
	{
		DataPool.NOW_VOLUME =10*(evt.id);
		DataPool.SO.setVolume(DataPool.NOW_VOLUME);
		DataPool.SKIN.soundBtn.iconMC._visible = false;
	}
	private function loadingFlv():Void
	{
		var pctLoaded:Number = Math.round(DataPool.NS.bytesLoaded/DataPool.NS.bytesTotal * 100);
		DataPool.SKIN.loadingBar._width = DataPool.SKIN.durationBG._width * pctLoaded/100;  	
		checkBufferTime();	
		trace(pctLoaded.toString());
  		if (pctLoaded>=100) 
	    {
	   		clearInterval(DataPool.loadingInterVal);
	    }
	}
	
	private function playingFlv():Void{
		var playTime:Number = DataPool.NS.time;
		var pctPlayed:Number = Math.round(playTime/DataPool.FLV_DURATION * 100);
		var dragBox:MovieClip = DataPool.SKIN.dragBtn ;
		dragBox._x = pctPlayed * dragBox._parent.durationBG._width /100 ;
		DataPool.SKIN.statusBar._width = dragBox._x + dragBox._width/2;
		var statusStr:String = Swfit.formatTime(playTime) + "/" + Swfit.formatTime(DataPool.FLV_DURATION);
		trace("playingFlv"+statusStr);
		DataPool.SKIN.infoTxt.text = statusStr ;
		if (pctPlayed>=100 && playTime !=0) {
	   		clearInterval(DataPool.statusInterVal);
	    }
	}

	private function fullScreen():Void
	{
		if(Stage["displayState"] == "normal")
		{
			Stage["displayState"] = "fullScreen";
			//
			DataPool.SKIN.controlBar._visible = false ;
			var myVideo:Video = DataPool.SKIN.videoMC.theVideo ;
			myVideo._width = DataPool.STAGE_WIDTH - 2*OFFSET ; 
			myVideo._height = DataPool.STAGE_HEIGHT - 2*OFFSET ;
			//
		}
		else 
		if(Stage["displayState"] == "fullScreen")
		{
			Stage["displayState"] = "normal";
			//
			DataPool.SKIN.controlBar._visible = true;
			var myVideo:Video = DataPool.SKIN.videoMC.theVideo ;
			myVideo._width = DataPool.STAGE_WIDTH - 2*OFFSET ; 
			myVideo._height = DataPool.STAGE_HEIGHT - 5*OFFSET ;
			//
		}
	}
	
	private function onClickVideo(evt:Object):Void
	{
		
		trace("onClickVideo");
		DataPool.NS.pause();
		DataPool.SKIN.pauseIcon._visible = !DataPool.SKIN.pauseIcon._visible ;
		DataPool.SKIN.playBtn._visible = !DataPool.SKIN.playBtn._visible ;
		DataPool.SKIN.pauseBtn._visible = !DataPool.SKIN.pauseBtn._visible ;

	}
	
	private function dragFlv():Void
	{
		var dragBox:MovieClip = DataPool.SKIN.dragBtn ;
		var nowTime:Number = Math.round(DataPool.FLV_DURATION * (dragBox._x)/dragBox._parent.durationBG._width) ;
		DataPool.SKIN.statusBar._width = dragBox._x + dragBox._width/2;
		DataPool.NS.seek(nowTime);
	
	}
	//
	private function checkBufferTime():Void
	{
		if(DataPool.NS.bufferLength < DataPool.NS.bufferTime)
		{
			if(!this.inBuffering)
			{
				DataPool.NS.pause();
				this.inBuffering = true ;
			}
			
		}
		else
		{
			if(this.inBuffering)
			{
				DataPool.NS.pause();
				this.inBuffering = false ;
			}
		}
	}
	//
	private function center(mc:MovieClip,center:Boolean):Void
	{
		mc._x = (DataPool.STAGE_WIDTH - mc._width)/2;
		if(!center){
			mc._y = DataPool.STAGE_HEIGHT - mc._height ;
		}
		else
		{
			mc._y = (DataPool.STAGE_HEIGHT - mc._height)/2;
		}
	}
	
}