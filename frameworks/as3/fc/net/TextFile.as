package fc.net 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import fc.errors.Errors;		

	/**
	 * 加载文本
	 * @author GaoXian
	 */
	public class TextFile extends LoaderObject 
	{
		private var urlLoader 	: URLLoader ;
		private var urlRequest	: URLRequest ;
		private var _path 	: String ;
		private var _SRC	: String ;
		
		public function get src():String
		{
			return _SRC;
		}
		public function TextFile(URL:String = null)
		{
			if(URL != null)
			{
				if(URL == "")
				{
					throw new Error(Errors.URLisEmpty);
				}
				_path = URL;
				loadText();
			}
		}
		public function loadTextFile(URL : String):void
		{
			if(URL == "")
			{
				throw new Error(Errors.URLisEmpty);
			}
			_path = URL;
			loadText();
		}
		
		private function loadText():void
		{
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT ;
			urlRequest = new URLRequest();
			urlRequest.url = _path ;
			urlLoader.load(urlRequest);
			super.configureListeners(urlLoader);
		}

		override protected function onLoadSuccess(e:Event):void
		{
			_SRC = String(urlLoader.data);
			super.onLoadSuccess(e);
		} 
	}
}
