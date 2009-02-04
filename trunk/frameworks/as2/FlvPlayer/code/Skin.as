import mx.events.EventDispatcher;
/**
 * @author Gaoxian
 * @version ActionScript 2.0
 */
class Skin {
	
	public var bgMC : MovieClip ;
	public var mainMC : MovieClip ;
	public var videoMC : MovieClip ;
	public var loadingBar : MovieClip ;
	public var pauseIcon : MovieClip ;
	public var playIcon : MovieClip ;
	
	public var  controlBar:MovieClip ;
	public var playBtn:MovieClip ;
	public var pauseBtn:MovieClip ;
	public var fullScreenBtn:MovieClip ;
	public var durationMC:MovieClip ; 
	public var statusBar:MovieClip ;
	public var infoTxt:TextField ;
	public var dragBtn:MovieClip ;
	public var durationBG:MovieClip ;
	
	public var stopBtn:MovieClip ;
	
	public var soundAsset:MovieClip;
	public var soundBtn:MovieClip ;
	public var soundCotrolMC:MovieClip ;
	
	//Event type
	public static var SKIN_COMPLETE:String = "Complete";
	public static var CKICK_VIDEO:String = "click";
	public static var DOUBLE_CLICK_VIDEO:String = "doubleClick";
	
	public static var START_PLAY:String = "clickPlayBtn" ;
	public static var PAUSE:String = "clickPauseBtn";
	
	public static var CLICK_FULLSCREEN_BUTTON:String = "fullscreen";
	
	public static var START_DRAG:String = "startDrag";
	public static var STOP_DRAG:String = "stopDrag";
	
	public static var STOP_FLV_PLAY:String = "stop";
	
	public static var CLICK_SOUND_BUTTON:String = "soundbtns";
	public static var CLICK_SOUND_CONTROL:String = "soundControl";
	//
	public var addEventListener:Function;
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	//
	public function Skin(){
		EventDispatcher.initialize(this);
		createBG();
		prepare();
		
	}
	
	private function prepare():Void{
		trace("Skin Prepare");
		var _this:Object = this;
		mainMC = _root.createEmptyMovieClip("main",1);
		var lis:Object = new Object();
		//
		lis.onLoadProgress  = function():Void{
			trace("onPregress");
		};
		//
		lis.onLoadInit = function():Void{
			trace("Skin OnloadInit");
			_this.init();
		};
		var mcl:MovieClipLoader = new MovieClipLoader();
		mcl.addListener(lis);
		mcl.loadClip(DataPool.SKIN_PATH,mainMC);
	
	
	}
	private function createBG():Void{
		
		bgMC = _root.createEmptyMovieClip("bg",0);
		Swfit.drawRect(bgMC,DataPool.BG_COLOR,DataPool.STAGE_WIDTH,DataPool.STAGE_HEIGHT);
		
		
	}
	private function init():Void{
		
		videoMC = mainMC.attachMovie("flvPlayer","flvPlayer",0);
		controlBar = mainMC.attachMovie("controlBar","controlBar",1);
		
		playIcon = mainMC.attachMovie("playIcon","playIcon",2);
		pauseIcon = mainMC.attachMovie("pauseIcon","pauseIcon",3);
		//
		playBtn = controlBar.playBtn ;
		pauseBtn = controlBar.pauseBtn ; 
		fullScreenBtn = controlBar.fullScreenBtn ;
		stopBtn = controlBar.stopBtn ;
		
		soundAsset = _root.createEmptyMovieClip("soundAsset",2);
		soundBtn = controlBar.soundBtn ;
		soundCotrolMC = controlBar.soundCotrolMC ;
		//status
		durationMC = controlBar.durationMC ;
		loadingBar = durationMC.loadingBar ;
		statusBar = durationMC.statusBar ;
		infoTxt = durationMC.infoTxt ;
		dragBtn = durationMC.dragBtn ;
		durationBG = durationMC.durationBG ;
		
		playBtn._visible = true;
		pauseBtn._visible = false;
		playIcon._visible = false ;
		pauseIcon._visible = false ;
		
		
		loadingBar._width = statusBar._width =  0 ;
		dragBtn._x = 0 ;
		
		setEvent();
		this.dispatchEvent({type:Skin.SKIN_COMPLETE});
	
	}

	private function setEvent():Void{
		var _this:Object = this;
		var firstTime:Number = 0;
		videoMC.onRelease = function():Void{
			trace("clickVideo......");
			var nowTime:Number = getTimer();
		
			if(nowTime - firstTime < 500){
				_this.dispatchEvent({type:Skin.DOUBLE_CLICK_VIDEO});
				
			}
	
			_this.dispatchEvent({type:Skin.CKICK_VIDEO});
			firstTime = nowTime;

		};
	
		playBtn.onRelease= playIcon.onRelease = function():Void
		{
			if(DataPool.FIRST_CLICK_PLAY)
			{
				_this.dispatchEvent({type:Skin.START_PLAY,target:this});
				DataPool.FIRST_CLICK_PLAY = false ;
				
			}
			else
			{
				_this.dispatchEvent({type:Skin.PAUSE,target:this});
			}
		};
	
		pauseBtn.onRelease = pauseIcon.onRelease= function():Void{
			_this.dispatchEvent({type:Skin.PAUSE,target:this});
		};
	
		fullScreenBtn.onRelease = function():Void{
			_this.dispatchEvent({type:Skin.CLICK_FULLSCREEN_BUTTON,target:this});
		};
		
		dragBtn.onPress = function():Void{
			this.startDrag(false,0,0,this._parent.durationBG._width - this._width/2,0);
			_this.dispatchEvent({type:Skin.START_DRAG});
		};
		
		dragBtn.onRelease = dragBtn.onReleaseOutside =function():Void{
			this.stopDrag();
			_this.dispatchEvent({type:Skin.STOP_DRAG});
	
		};
		stopBtn.onRelease = function():Void{
			DataPool.FIRST_CLICK_PLAY = true ;
			_this.dispatchEvent({type:Skin.STOP_FLV_PLAY});
		};
		soundBtn.onRelease = function():Void{
			_this.dispatchEvent({type:Skin.CLICK_SOUND_BUTTON,target:this});
		};
		for(var i:Number = 1 ; i < 11 ; i++){
			soundCotrolMC["item"+i].onRelease = function():Void{
				this.id = Number(this._name.substring(4)) ;
				trace(this.id.toString() + "[id]");
				for(var j:Number = 11 ; j>this.id ;j--){
					_this.soundCotrolMC["item"+j].gotoAndStop(2);
				}
				for(var k:Number = 1 ; k <= this.id ;k++){
					_this.soundCotrolMC["item"+k].gotoAndStop(1);
				}
				_this.dispatchEvent({type:Skin.CLICK_SOUND_CONTROL,target:this,id:this.id});
			};
		}
	}
	
	
	
}