package fc.net 
{
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import fc.errors.Errors;
	import fc.net.LoaderObject;		

	/**
	 * @author GaoXian
	 * @date  2008-5-9
	 */
	public class ClassLoader extends LoaderObject 
	{
		private var _swfPath : String ; 
		private var _loader : Loader ; 
		private var urlRequest : URLRequest ; 

		/**
		 * 构造函数
		 * 加载swf文件,使用其中的资源类
		 * @param source 要加载的类文件路径 ,可选
		 */
		public function ClassLoader(source : String = null) 
	    {
	    	if(source != null)
	    	{
	    		if(source == "")throw new Error(Errors.URLisEmpty);
	    		_swfPath = source ;
				load();
	    	}
		}
		/**
		 * 加载操作
		 * @param source 要加载的类文件路径 
		 */
		public function loadSwf(source:String):void
		{
			if(source == "") throw new Error(Errors.URLisEmpty);
			_swfPath = source ;
			load();
		}
		/**
		 * 执行加载
		 */
		private function load():void
		{
			_loaded = false;
			_failed = false;
			_loadrate = 0;
			_loader = new Loader();
			urlRequest = new URLRequest();
			urlRequest.url = _swfPath ;
			super.configureListeners(_loader.contentLoaderInfo);
			//
			var context : LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain ;
			_loader.load(urlRequest, context);
		}
		/**
		 * 
		 * @param className 类名称
		 */
		public function getClass(className:String):Class 
		{
        	try 
        	{
				return _loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
        	}
        	catch (e:Error) 
        	{
            	throw new IllegalOperationError(className + " definition not found in " + _swfPath);
			}
    	    return null;
    	}
		/**
		 * override the same Methods in base Class
		 * @param e 事件
		 */
		override protected function onLoadSuccess(e : Event) : void
		{
			super.onLoadSuccess(e);
		}
		/**
		* 设置加载目标路径
		* Get function for _swfLib.
		* @return _name : type
		*/
		public function get contentPath () : String 
		{
			return _swfPath;
		}
		
		/**
		* Set function for _name.
		* @param value : type
		*/
		public function set contentPath (value : String):void 
		{
			_swfPath = value;
		}
		
		public function get loader():Loader
		{
			return _loader ;
		}
	}
}
