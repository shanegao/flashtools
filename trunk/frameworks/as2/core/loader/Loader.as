//这个类位于mx.events中.需要在使用前导入
import mx.events.EventDispatcher;
import code.core.events.LoadEvent ;
class code.core.loader.Loader {
	//定义几个常量来表示事件类型
	public static  var COMPLETE:String  = "complete";
	public static  var PROGRESS:String = "progress";
	public static  var ERROR:String     = "error";
	//定义用到MovieClip
	private var loader:MovieClip;
	private var tmpClip:MovieClip;
	private var isStart:Boolean = false ;
	//声明EventDispatcher类的方法,如果不声明的话,会提示找不到这些方法,不知道为什么???
	public var addEventListener:Function;
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	//构造
	public function Loader(container:MovieClip) 
	{
		EventDispatcher.initialize(this);
		init(container);
	}
	//初始化,生成用来加载图片的loader和一个用来使用enterFrame的临时MovieClip,加载成功后删除
	private function init(container:MovieClip):Void 
	{
		var theDepth:Number  = container.getNextHighestDepth();
		loader  = container.createEmptyMovieClip("loader"+theDepth,theDepth);
		tmpClip = container.createEmptyMovieClip("tmpClip",theDepth+1);
	}
	public function load(imageURL:String):Void 
	{
		loader.loadMovie(imageURL);
		var startTime:Number = getTimer();
		tmpClip.setter = this;
		tmpClip.loader = loader;
		tmpClip.onEnterFrame = function():Void
		{
			var loaded:Number = this.loader.getBytesLoaded();
			var total :Number = this.loader.getBytesTotal();
			if (!this.setter.isStart) 
			{
				this.setter.dispatchEvent({type:LoadEvent.LOAD_START, loader:this.loader,target:this.setter});
				this.setter.isStart = true;
			}
			if(total>0)
			{
				if(loaded>=total)
				{
					this.setter.dispatchEvent({type:LoadEvent.LOAD_COMPELET, loader:this.loader,target:this.setter});
					//{type:ImageLoader.COMPLETE, target:this.loader}是一个Object,传递给侦听器
					this.removeMovieClip();
				}
				else
				{
					var precent:Number = Math.floor(loaded / total * 100);
					this.setter.dispatchEvent({type:LoadEvent.LOAD_PREGRESS, loader:this.loader,loaded:precent,target:this.setter});
				}
			}	
			else if(loaded == 0 && (getTimer() - startTime)>10000)
			{
				this.setter.dispatchEvent({type:LoadEvent.LOAD_ERROR, loader:this.loader,target:this.setter});
				this.removeMovieClip();
				//加载成功后删除
			}
			
		};
	}
}