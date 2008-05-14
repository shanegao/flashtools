﻿package fc.net 
{
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import fc.errors.Errors;		

	/**
	 * 加载SWF文件 , 类
	 * @author Gaoxian
	 */ 
	public class DisplayLoader extends LoaderObject 
	{
		private var _swfLib : String ;
		private var _loader : Loader ;
		private var urlRequest : URLRequest ;
		private var swfClass	:Class ;
		private var is_class	:Boolean ;
		//public var 
		/**
		 * 构造函数
		 */
		public function DisplayLoader(URL : String = null) 
	    {
	    	if(URL!=null)
	    	{
	    		if(URL == "")throw new Error(Errors.URLisEmpty);
	    		_swfLib = URL ;
				load();
	    	}
		}
		
		public function loadSwf(URL:String,isClass: Boolean = false):void
		{
			trace("loadSwf : "  +URL);
			if(URL == "") throw new Error(Errors.URLisEmpty);
			_swfLib = URL ;
			is_class = isClass ;
			load();
		}
		
		private function load():void
		{
			_loaded = false;
			_failed = false;
			_loadrate = 0;
			_loader = new Loader();
			urlRequest = new URLRequest();
			urlRequest.url = _swfLib ;
			super.configureListeners(_loader.contentLoaderInfo);
			if(is_class)
			{
				var context : LoaderContext = new LoaderContext();
				context.applicationDomain = ApplicationDomain.currentDomain ;
				_loader.load(urlRequest, context);
			}
			else _loader.load(urlRequest);
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
            	throw new IllegalOperationError(className + " definition not found in " + swfLib);
	        }
    	    return null;
    	}
		/**
		 * override the same Methods in base Class
		 * @param e 事件
		 */
		override protected function onLoadSuccess(e:Event):void
		{
			super.onLoadSuccess(e);
		}
		/**
		* 设置加载目标路径
		* Get function for _swfLib.
		* @return _name : type
		*/
		public function get swfLib () : String 
		{
			return _swfLib;
		}
		
		/**
		* Set function for _name.
		* @param value : type
		*/
		public function set swfLib (value : String):void 
		{
			_swfLib = value;
		}
		
		public function get loader():Loader
		{
			return _loader ;
		}
		
	}
}