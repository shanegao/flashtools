package fc.events 
{
	import flash.net.FileReference;	
	import flash.events.Event;
	
	/**
	 * @author GaoXian
	 */
	public class UploadEvent extends Event 
	{
		/**
		 * 当上传开始时调用
		 */
		public static const UPLOAD_START : String = "upload@start";
		/**
		 * 当上传出错时调用
		 */
		public static const UPLOAD_FAIL : String = "upload@fail";
		/**
		 * 上传进程
		 */
		public static const UPLOAD_PROGRESS : String = "uploading";
		/**
		 * 上传成功时调
		 */
		public static const UPLOAD_SUCCESS : String = "upload@success";
		/**
		 * 上传列表完成后调用
		 */
		public static const LIST_COMPLETE :String = "listComplete";
		/**
		 * 单个文件上传完成后调用
		 */
		public static const ITEM_COMPLETE :String = "itemComplete";
		/**
		 * 单个文件上传失败
		 */
		public static const ITEM_FAIL	  :String = "itemFail";
		/**
		 * 当前上传的文件
		 */
		public var currentFile : FileReference ;
		/**
		 * 当前上传文件imageid
		 */
		/**
		 * 出错信息
		 */
		public var errorMsg : String ;
		public var currentID : int ;
		public var totalNum  : int ;
		public var id : int ;
		public var uploadPrecent : int ;
		
		public function UploadEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
