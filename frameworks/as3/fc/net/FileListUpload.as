package fc.net 
{
	import flash.events.*;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	
	import fc.errors.Errors;
	import fc.events.UploadEvent;
	import fc.utils.Debug;		

	/**
	 * 批量上传图
	 * @author GaoXian
	 */
	public class FileListUpload extends EventDispatcher 
	{
		//public var uploadBytes	:uint = 0;
		//public var totalBytes 	:uint = 0 ;
		private var fileNum				:int = 0 ;
		private var uploadURL	   		:URLRequest;
	    private var pendingFiles   		:Array;
	    private var _currentIndex		:int = 1 ;
	    private var _currentName		:String;
	    private var IsComplete			:Boolean = false ;
	    private var fileRefList  		:FileReferenceList ;
	    private var fileLength  		:int ;
	    private var _serverURL  		:String ;
	  

		//setter and getter Methods
		/**
		 * 设置上传服务器端程序路径
		 */
		public function set serverURL(_url:String):void
		{
			if(_url == null)
				throw new Error(Errors.paramIsInvalid);
			_serverURL	= _url ;
		}	
		public function get serverURL():String
		{
			return _serverURL ;
		}
		/**
		 * 并发上传 暂时不用
		 */
		private var _limitNum : int = 5 ; 
		public function set limitNum(num:int):void
		{
			if(num > 0 && num < pendingFiles.length)
			_limitNum = num ;
		}
		public function get limitNum():int
		{
			return _limitNum;
		}
		/**
		 * 上传文件大小限制
		 * 单位k
		 */	
		private var _maxSize : int = 2*1024*1024;
		public function set maxSize(mb : Number):void
		{
			if(mb > 0 && mb < 100*1024)
				_maxSize = mb*1024 ;
		}
		public function get maxSize():Number
		{
			return _maxSize/1024;
		}
		/**
	    * @author GaoXian
		*
		*/
		public function FileListUpload() 
	    {
	    	_currentIndex = 1 ;
			fileNum = 0 ;
			uploadURL = new URLRequest();
			fileRefList = new FileReferenceList();
			initializeListListeners(fileRefList);
		}
		/**
		 * 添加侦听
		 * @param	list FileReferenceList对象
		 */
		private function initializeListListeners(list : FileReferenceList) : void 
	    {
	        list.addEventListener(Event.SELECT, selectHandler);
	        list.addEventListener(Event.CANCEL, cancelHandler);
	    }
		/**
		 * 执行浏览操作
		 * @return 是否成功执行
		 */
	    public function browse(): Boolean
	    {
	        var allTypes:Array = new Array();
	        allTypes.push(new FileFilter("Images(*.jpg, *.jpeg, *.gif, *.png,*.bmp)", "*.jpg;*.jpeg;*.gif;*.png;*.bmp"));
	        return fileRefList.browse(allTypes);
		}
		/**
		 * 完成所有的文件上传时
		 * dispatchEvent
		 */
	    private function doOnComplete():void 
	    {
	    	IsComplete = true ;
	        var event:UploadEvent = new UploadEvent(UploadEvent.LIST_COMPLETE);
	        event.totalNum = fileLength ;
	        dispatchEvent(event);
	    }
	 	/**
	 	 * 注册单个FileReference对象的侦听器
	 	 */
	    private function addPendingFile(file:FileReference):void 
	    {
	    	trace("addPendingFile : " + file.name);
	        file.addEventListener(Event.CANCEL, cancelHandler);
	        file.addEventListener(Event.COMPLETE, completeHandler);
	        file.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
	        file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	        file.addEventListener(Event.OPEN, openHandler);
	        file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
	        file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadCompleteDataHandler);
	    }
		/**
	 	 * 选择侦听
	 	 */
	    private function selectHandler(event:Event):void 
	    {
	    	var list : FileReferenceList = event.target as FileReferenceList ;
	    	fileLength = list.fileList.length ;
			trace("selectHandler: " + list.fileList.length + " files");
	        pendingFiles = [];
	        fileNum		 = fileLength ;
			var file:FileReference ;
	        for (var i:uint = 1; i < fileNum; i++) 
	        {
	            file = FileReference(list.fileList[i]);
				pendingFiles.push(file);
	            addPendingFile(file);
	        }
			//解决选中的文件最后一个到最前的问题
			pendingFiles.push(list.fileList[0]);
			addPendingFile(list.fileList[0]);
	        doOnStart();
	    }
	    /**
	     * 开始执行
	     */
	     public function run():void
	     {
			Debug.out("开始执行上传");
			doNextUpload();
	     }
		/**
		 * 当一个文件上传完成后调用此方法，
		 * 开始下一个文件的上传
		 */
	    private function doNextUpload():void
	    {
	    	if(IsComplete)return ;
	    	var f : FileReference = pendingFiles.shift() as FileReference;
	    	/**
	    	 * maxSize
	    	 */
	    	if(f != null &&	f.size	<=	_maxSize)	
	    	{
				//uploadURL.url = _serverURL + "&imageid=" +Config.FLASH_PHID;
				f.upload(uploadURL);
				Debug.out("uploadURL : " + uploadURL.url);
	    	}
	    	else if(f.size >_maxSize)
	    	{
	    		doOnItemFail(f,Errors.fileSizeInValid);
	    	}
		}
		/**
		 * 单个文件，上传成功时，派发一个事件
		 * @param file
		 */
	    private function doOnItemComplete(file : FileReference):void
	    {
	    	_currentName = file.name ;
	    	var e : UploadEvent = new UploadEvent(UploadEvent.ITEM_COMPLETE);
			e.currentFile = file ;
			//e.currentID = Config.FLASH_PHID;
			e.id = _currentIndex ;
			e.totalNum = fileLength ;
			dispatchEvent(e);
			//Config.FLASH_PHID++;
			_currentIndex ++ ;
			if(_currentIndex > fileLength) doOnComplete();
	    }
		/**
		 * 单个文件，上传失败时调用，派发失败事件
		 * @param	file
		 */
		private function doOnItemFail(file :FileReference,err :String):void
		{
	    	_currentName = file.name ;
	    	var e : UploadEvent = new UploadEvent(UploadEvent.ITEM_FAIL);
			e.errorMsg = err ;
			e.currentFile = file ;
			//e.currentID = Config.FLASH_PHID;
			e.id = _currentIndex ;
			e.totalNum = fileLength ;
			dispatchEvent(e);
			//Config.FLASH_PHID++;
			_currentIndex ++ ;
			if(_currentIndex > fileLength) doOnComplete();
			else doNextUpload();
		}
		/**
		 * 上传开始时候调用
		 */
	    private function doOnStart():void
	    {
	    	var ee: UploadEvent = new UploadEvent(UploadEvent.UPLOAD_START );
			ee.totalNum = fileLength ;
			dispatchEvent(ee);
	    }
		/**
	 	 * 用户取消上传
	 	 */
	    private function cancelHandler(event:Event):void 
	    {
	    	
	    }
	 	/**
	 	 * 打开文件s
	 	 * @param	event
	 	 */
	    private function openHandler(event:Event):void 
	    {
	        var file:FileReference = FileReference(event.target);
	        trace("openHandler: name=" + file.name);
	    }
	 	/**
		 * 进度侦听
	 	 */
	    private function progressHandler(event:ProgressEvent):void 
	    {
		}
	 	/**
	 	 * 上传完成 	 	 
		 */
	    private function completeHandler(event:Event):void 
	    {
	        var file:FileReference = FileReference(event.target);
	        trace("completeHandler: name=" + file.name);
	        doOnItemComplete(file);
	        doNextUpload();
	    }
	    /**
		 *上传完成，得到数据侦听时调用 
		 */
		private function uploadCompleteDataHandler(event : DataEvent) : void
		{
			
		}
	 	/**
	 	 * IO Error
	 	 */
	    private function ioErrorHandler(event:IOErrorEvent):void 
	    {
	        var file:FileReference = FileReference(event.target);
			var err : String = event.text as String ;
	        doOnItemFail(file,err);
	    }
	 	/**
	 	 * security Error
	 	 */
	    private function securityErrorHandler(event:SecurityErrorEvent):void 
	    {
	        var file:FileReference = FileReference(event.target);
	        var err : String = event.text as String ;
	        doOnItemFail(file,err);
	    }
	    /**
		 *	http error
		 * 	当上载失败并且存在可用来描述失败的 HTTP 状态代码时调度。
		 * 调度 httpStatus 事件之后，将调度 ioError 事件。
		 */
		private function httpStatusHandler(event : HTTPStatusEvent) : void
		{
			//var file:FileReference = FileReference(event.target);
			Debug.out("HTTPStatusEvent :" + event.status);
		}
	
		
	}
}
