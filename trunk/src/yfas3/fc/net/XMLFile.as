package fc.net {
	import fc.errors.Errors;	
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;	

	/**
	 * 此类用于加载xml格式的文
	 * @author GaoXian
	 */
	public class XMLFile extends LoaderObject 
	{
		private var urlLoader 	: URLLoader ;
		private var urlRequest	: URLRequest ;
		private var _xmlPath 	: String ;
		private var xml			: XML ;
		private var _imageid : int ;
		private var _id :int ;
		private var _totalNum :int ;
		
		public function set totalNum(num:int):void
		{
			_totalNum = num ;
		}
		public function get totalNum():int
		{
			return _totalNum;
		}
		public function get id():int
		{
			return _id ;
		}
		public function set id(_index: int):void
		{
			_id = _index ;
		}
		public function get imageid():int
		{
			return _imageid ;
		}
		public function get xmlData():XML
		{
			return xml ;
		}
		public function XMLFile(URL:String = null):void
		{
			if(URL != null)
			{
				if(URL == "")
				{
					throw new Error(Errors.URLisEmpty);
				}
				_xmlPath = URL;
				loadXML();
			}
		}
		
		public function loadXMLFile(URL:String):void
		{
			if(URL == "")
			{
				throw new Error(Errors.URLisEmpty);
			}
			_xmlPath = URL;
			urlRequest = new URLRequest(_xmlPath);
			loadXML();
		}
		
		private function loadXML():void
		{
			_loaded = false;
			_failed = false;
			_loadrate = 0;
			//
			urlLoader  = new URLLoader();
			super.configureListeners(urlLoader);
			urlLoader.load(urlRequest);
		}
		/**
		 * POST传递数然后load
		 * @param URL 要访问的服务器
		 * @param data 要传递的数据
		 */
		public function sendAndLoad(URL:String,data:*):void
		{
			if(URL == "")
			{
				throw new Error(Errors.URLisEmpty);
			}
			_xmlPath = URL;
			urlRequest = new URLRequest(_xmlPath);
			urlRequest.method = URLRequestMethod.POST ;
			urlRequest.contentType =  "text/xml";
			urlRequest.data = data ;
			loadXML();
			
		}
		//
		override protected function onLoadSuccess(e:Event):void
		{
			xml = new XML(urlLoader.data);
			super.onLoadSuccess(e);
		} 
	}
}
