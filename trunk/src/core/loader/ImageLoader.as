//这个类位于mx.events中.需要在使用前导入
import mx.events.EventDispatcher;
class code.core.loader.ImageLoader {
	//定义几个常量来表示事件类型
	public static  var COMPLETE:String  = "complete";
	public static  var PROGRESS:String = "progress";
	public static  var ERROR:String     = "error";
	//定义用到MovieClip
	private var loader:MovieClip;
	private var tmpClip:MovieClip;
	//声明EventDispatcher类的方法,如果不声明的话,会提示找不到这些方法,不知道为什么???
	public var addEventListener:Function;
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	//构造
	public function ImageLoader(container:MovieClip) {
		EventDispatcher.initialize(this);
		init(container);
	}
	//初始化,生成用来加载图片的loader和一个用来使用enterFrame的临时MovieClip,加载成功后删除
	private function init(container:MovieClip):Void {
		var theDepth:Number  = container.getNextHighestDepth();
		loader  = container.createEmptyMovieClip("loader"+theDepth,theDepth);
		tmpClip = container.createEmptyMovieClip("tmpClip",theDepth+1);
	}
	public function loadImage(imageURL:String):Void {
		loader.loadMovie(imageURL);
		var startTime:Number = getTimer();
		tmpClip.setter = this;
		tmpClip.loader = loader;
		tmpClip.onEnterFrame = function():Void
		{
		var loaded:Number = loader.getBytesLoaded();
		var total :Number = loader.getBytesTotal();
		if(loaded>=total &&total!=0)
		{
		 
		this.setter.dispatchEvent({type:ImageLoader.COMPLETE, target:this.loader});
		//{type:ImageLoader.COMPLETE, target:this.loader}是一个Object,传递给侦听器
		this.removeMovieClip();
		}
		else if(loaded == 0 && (getTimer() - startTime)>10000)
		{
		this.setter.dispatchEvent({type:ImageLoader.ERROR, target:this.loader});
		this.removeMovieClip();
		//加载成功后删除
		}
		else
		{
		this.setter.dispatchEvent({type:ImageLoader.PROGRESS, target:this.loader,data:{bytesLoaded:loaded,bytesTotal:total}});
		}
		};
	}
}