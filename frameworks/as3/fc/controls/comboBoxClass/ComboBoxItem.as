package fc.controls.comboBoxClass {
	import fc.events.ComboBoxEvent;	
	
	import flash.geom.ColorTransform;	
	import flash.events.MouseEvent;	
	import flash.text.TextField;	
	import flash.display.Sprite;	
	
	/**
	 * comboBox 单元
	 * @author GaoXian
	 */
	public class ComboBoxItem extends Sprite 
	{
		/**
		 * 界面元件
		 */
		public var item_bg : Sprite ;
		public var itemTxt : TextField ;
		/**
		 * 私有成员
		 */
		private var i_label : String ;
		private var i_width  : Number ; 
		private var i_height : Number ; 
		private var _index : Number ; 
		/**
		 * @author GaoXian
		 * @param h <b>高</b>
		 * @param w 宽
		 * @param label 列表单元信息
		 */
		public function ComboBoxItem(label :String , w :Number , h : Number)
		{
			trace("构造一个ComboBoxItem对象" + [label,w,h]);
			this.mouseChildren = false ; 
			this.i_label = label ;
			this.i_width = w ;
			this.i_height = h ; 
			changeColor(0x999999);
			initListeners();
			initView();
		}
		/**
		 * 初始化界面
		 */
		private function initView():void
		{
			item_bg.width = i_width ;
			item_bg.height = i_height ;
			itemTxt.text = i_label ; 
		}
		/**
		 * 侦听
		 */
		private function initListeners():void
		{
			this.addEventListener(MouseEvent.CLICK, onSelected);
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		/**
		 * 鼠标划出
		 */
		private function onOut(event : MouseEvent) : void
		{
			changeColor(0x999999);
		}
		/**
		 * 鼠标划上
		 */
		private function onOver(event : MouseEvent) : void
		{
			changeColor(0x777777);
		}
		/**
		 * 选中
		 */
		private function onSelected(event : MouseEvent) : void
		{
			var e : ComboBoxEvent = new ComboBoxEvent(ComboBoxEvent.SELECTED);
			dispatchEvent(e);
		}
		/**
		 * 改变背景颜色
		 */
		private function changeColor(value : uint):void
		{
			var colorInfo : ColorTransform = item_bg.transform.colorTransform;
		    colorInfo.color = value;
		    item_bg.transform.colorTransform = colorInfo;
			
		}
		/**
		 * 序号
		 */		
		public function get index():int
		{
			return _index ; 
		}
		public function set index(id :int):void
		{
			_index = id ;
		}
	}
}
