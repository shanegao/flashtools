package fc.net 
{
	import fc.events.LoadEvent;	

	import flash.events.SecurityErrorEvent;	
	import flash.events.HTTPStatusEvent;	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	/**
	 * 
	 * @author GaoXian
	 */
	public class LoaderObject extends EventDispatcher
	{
		protected var _loaded:Boolean = false;
		protected var _failed:Boolean = false;
		protected var _loadrate:Number = 0;
		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		public function get failed():Boolean
		{
			return _failed;
		}
		
		public function get rate():Number
		{
			return _loadrate;
		}
		/**
		 * 添加侦听
		 */
		protected function configureListeners(target:EventDispatcher):void
		{
			target.addEventListener(Event.COMPLETE, onLoadSuccess);
			target.addEventListener(ProgressEvent.PROGRESS, onLoading);
			target.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);   
            target.addEventListener(Event.OPEN, openHandler);
            target.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            target.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
		}
		/**
		 * IO错误
		 */
		private function ioErrorHandler(e : IOErrorEvent):void
		{
			onLoadFailed(e.text);
		}
		/**
		 * @param e
		 */
		private function openHandler(e:Event):void
		{
		}
		/**
		 * 侦听http状态
		 */
		private function httpStatusHandler(e : HTTPStatusEvent) : void
		{
		}
		/**
		 * 安全错误
		 */
		private function securityErrorHandler(e : SecurityErrorEvent):void
		{
			onLoadFailed(e.text);
		}
		/**
		 * 成功加载
		 */
		protected function onLoadSuccess(e:Event):void
		{
			_loaded = true;
			_failed = false;
			_loadrate = 1;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			dispatchEvent(ee);
		}
		/**
		 * 加载中
		 */
		protected function onLoading(e:ProgressEvent):void
		{
			_loaded = false;
			_failed = false;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOADING);
			ee.loadedBytes = e.bytesLoaded;
			ee.totalBytes = e.bytesTotal;
			ee.loadedRate = Math.round(ee.loadedBytes / ee.totalBytes * 100);
			_loadrate = ee.loadedRate;
			dispatchEvent(ee);
		}
		/**
		 * 加载出错时调用
		 */
		protected function onLoadFailed(errMsg:String):void
		{
			_loaded = false;
			_failed = true;
			_loadrate = 0;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			ee.errorMsg = errMsg; 
			dispatchEvent(ee);
		}
	}
}
