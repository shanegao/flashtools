package fc.controls 
{
	import fc.events.ComboBoxEvent;	
	import fc.controls.comboBoxClass.ComboBoxItem;	
	import fc.controls.comboBoxClass.ComboBoxMainUI;	
	
	import flash.events.Event;	
	import flash.events.MouseEvent;	
	import flash.display.Sprite;
	/**
	 * combobox
	 * @author GaoXian
	 */
	public class ComboBox extends Sprite 
	{
		//界面元件
		public var bgMc : Sprite ;
		public var cbb_mainUI : ComboBoxMainUI ;
		//
		private var _data : Array ;
		private var c_width : Number = 100;
		private var c_height : Number = 20 ;
		private var isExpand : Boolean = false ; 
		private var itemContainer : Sprite ;
		/**
		 * 构造函数 
		 */
		public function ComboBox()
		{
			super();
			initView();
			
			_data = [{label:"aaaaaaa"},{label:"bbbbbbb"},{label:"ccccccccc"}];
		}
		
		/**
		 * 初始化界面
		 */
		private function initView():void
		{
			trace("initView..........................");
			removeChild(bgMc);
			cbb_mainUI = new ComboBoxMainUI("ComboBox",c_width, c_height);
			cbb_mainUI.addEventListener(MouseEvent.CLICK, onClick);
			addChild(cbb_mainUI);
		}
		
		/**
		 * click event handler
		 */
		private function onClick(evt : MouseEvent):void
		{
			isExpand = !isExpand ;
			if(isExpand) expand();
			else unExpand();
		}
		/**
		 * 展开
		 */
		private function expand() : void
		{
			trace("expand---------------------");
			bgMc.width = c_width ; 
			var itemWidth : Number = c_width ;
			var itemHeight : Number = 20 ;
			bgMc.height = _data.length * (itemHeight + 1);
			bgMc.y = cbb_mainUI.height ; 
			addChild(bgMc);
			itemContainer = new Sprite();
			for(var i : int = 0 ; i < _data.length ; i ++ )
			{
				var __label : String = String(_data[i].label);
				var item : ComboBoxItem = new ComboBoxItem(__label,itemWidth,itemHeight);
				item.x = 0 ; 
				item.y = bgMc.y  + i*(itemHeight + 1);
				item.index = i ;
				item.addEventListener(ComboBoxEvent.SELECTED, onItemSelect);
				itemContainer.addChild(item);
			}
			addChild(itemContainer);
			//updateView();
		} 
		/**
		 * 收缩
		 */
		private function unExpand():void
		{
			bgMc.addEventListener(Event.REMOVED, onBgRemove);
			removeChild(bgMc);
		}
		/**
		 * bgMc 被removeChild时候调用
		 */
		private function onBgRemove(e : Event):void
		{
			trace("removing.................................");
			while(itemContainer.numChildren>0)
			{
				itemContainer.removeChildAt(0);
			}
		}
		/**
		 * 当单元被选中时调用
		 */
		private function onItemSelect(evt : ComboBoxEvent) : void
		{
			var item : ComboBoxItem = evt.target as ComboBoxItem ;
			trace(item.index);
			cbb_mainUI.selectedText = _data[item.index].label ; 
			closeList();
		}
		/**
		 * 关闭列表
		 */
		private function closeList():void
		{
			isExpand = false ;
			unExpand();
		}

		/**
		 *	更新显示界面 
		 */
		
		private function updateView():void
		{
			
		} 
		 /**
		  * 设置数据单元
		  * 格式 [{label:value},{},....]
		  */

		public function set dataProvider(datas :Array):void
		{
		  _data = datas ;
		  updateView();
		}
		 
		 /**
		  * 获取数据单元
		  */ 
		public function get dataProvider() : Array
		{
			return _data ;
		}
	}
}

