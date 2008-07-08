package com.qoolu.games.box.view.components {
	import flash.geom.Point;	
	import flash.events.MouseEvent;	
	import flash.display.Sprite;	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.qoolu.games.box.view.components.blockys.Blocky;
	import com.qoolu.games.box.view.components.manager.BlockyManager;		

	/**
	 * @author Gaoxian
	 * 游戏界面
	 */
	public class GamingUI extends MovieClip 
	{
		public static const SELECTED : String = "userSelected..";
		public static const BUILD_COMPLETE : String = "bulidComplete";
		public var boardMc : MovieClip ;
		public var scoreMc : MovieClip ;
		public var cutdownMc : MovieClip ;
		
		private var cutdownTimer : CutdownTimer ;
		private var startDraw : Boolean ;
		
		private var _gamingData : Array  ;
		private var border : Sprite ;
		private var startPoint : Point = new Point ;
		private var _startBlocky : Blocky ;
		private var _endBlocky : Blocky ;
		
		private var rolesArr :Array ;
		private var itemW: Number = 0 ;
		private var itemH: Number = 0 ;
		public function GamingUI()
		{
			trace("GamingUI created ! " + boardMc.name);
			initUI();
		}
		/**
		 * 创建方块
		 */
		public function build(nums : Array, roles:Array) : void
		{
			//trace(nums , roles);
			while(boardMc.numChildren > 1) 
			{
				trace("build " +boardMc.numChildren);
				boardMc.removeChildAt(boardMc.numChildren - 1) ;
			}
			
			border = new Sprite();
			rolesArr = roles ;
			var wNum : int = nums[0] as int ;
			var hNum : int = nums[1] as int ;

			itemW = Math.floor(boardMc.width / wNum);
			itemH = Math.floor(boardMc.height / hNum); 
			_gamingData = [];			
			for(var i : int = 0 ; i <wNum ; i++)
			{
				_gamingData[i] = [] ; 
				for(var j : int = 0 ; j < hNum ; j++) createBlocky(i,j);
			}
			
			
			boardMc.addChild(border) ;
			/**
			 * 方块创建完成
			 */
			dispatchEvent(new Event(BUILD_COMPLETE)) ;
		}
		public function createBlocky(i : int , j : int): void
		{	
			var rebuild : Boolean = _gamingData[i][j] !=null ;
			if(_gamingData[i][j] !=null) boardMc.removeChild(_gamingData[i][j]);
			
			var blockyClass : String  = rolesArr[Math.floor(Math.random()* rolesArr.length)] as String; 
			var item : Blocky = BlockyManager.createBlocky(blockyClass) as Blocky;
			item.mouseChildren = false ;
			item.name = "blocky_"+i+"_"+j ;
			item.color = blockyClass ;
			item.pos = [i,j] ;
			item.x = i * itemW ;
			item.y = itemH * j ;
			item.width = itemW - 1 ;
			item.height = itemH - 1 ;
			boardMc.addChild(item);
			initBlocky(item);
			//存入数组
			_gamingData[i][j] = item ;
			//重建时候删除pet
			if(rebuild) item.removePet();
			//保持border在最上边
			boardMc.addChild(border) ;
		}
		/**
		 * 初始化方块信息
		 */
		private function initBlocky(item : Blocky)  :void
		{
			item.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler) ;
			item.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler) ;
		}
		/**
		 * 鼠标 松开
		 */
		private function mouseUpHandler(evt : MouseEvent) : void
		{
			if(border != null && boardMc.contains(border)) border.graphics.clear();
			startDraw = false ;
			//
			boardMc.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler) ;
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler) ;
			//当只选中一个,或者单行
			if(startBlocky == endBlocky || startBlocky.pos[0] == endBlocky.pos[0]
			|| startBlocky.pos[1] == endBlocky.pos[1]) return ;
			dispatchEvent(new Event(SELECTED)) ;
			//
		}
		/**
		 * 鼠标按下
		 */
		private function mouseDownHandler(evt : MouseEvent) : void
		{
			boardMc.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler) ;
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler) ;
			//
			startDraw = true ;
			var t : Blocky = evt.currentTarget as Blocky ;
			_startBlocky = t ;
			//
			border.graphics.lineStyle(4,0xFF0000);
			border.graphics.drawRect(0, 0, t.width, t.height);
			border.x = t.x + 1 ;
			border.y = t.y + 1 ;
			startPoint.x = t.x + 1 ;
			startPoint.y = t.y + 1 ;
		}
		/**
		 * 鼠标移动
		 */
		private function mouseMoveHandler(evt : MouseEvent) : void 
		{
			//trace("mouseMoveHandler : "  + evt.localX , evt.localY);
			var tName : String = String(evt.target.name) ;
			if(startDraw && tName.indexOf("blocky_") !=-1)
			{
				var t : Blocky = evt.target as Blocky ;
				border.graphics.clear();
				border.graphics.lineStyle(4,0xFF0000);
				
				var startX : Number = 0;
				var startY : Number = 0 ;
				var borderW : Number = 0 ;
				var borderH : Number = 0 ;
				if(t.x >= startPoint.x)
				{
					startX = startPoint.x ;
					borderW=  t.x+t.width -startPoint.x ;
					var bool : Boolean = Boolean(t.y >= startPoint.y );
					startY = bool ? startPoint.y : t.y;
					borderH= bool ? t.y+t.height-startPoint.y : startPoint.y + t.height -t.y ;
				}
				else
				{
					startX = t.x ;
					var bool2 : Boolean = Boolean(t.y >= startPoint.y );
					startY = bool2 ? startPoint.y : t.y;
					borderW=  bool2 ? startPoint.x +t.width - t.x : t.width + startPoint.x - t.x  ;
					borderH= bool2 ? t.y+t.height-startPoint.y : startPoint.y + t.height -t.y ;
				}
				
				border.graphics.drawRect(0, 0, borderW, borderH );
				border.x = startX ;
				border.y = startY ;
				//
				_endBlocky = t ;				
			}
		}
		/**
		 * 查找指定坐标内的blocky
		 * @param nowX x坐标
		 * @param nowY y坐标
		 */
		private function findItemByPos(nowX:  Number , nowY : Number) : Blocky
		{
			 for(var i : int = 0 ; i< gamingData.length ;i++)
			 {
				for(var j : int = 0 ; j <gamingData[i].length ; i++)
				{
					var item : Blocky = boardMc.getChildByName(gamingData[i][j] as String) as Blocky ;
					if(item.x <= nowX && item.x +item.width >= nowX && item.y <= nowY && item.y +item.height >= nowY)
					return item ;
				 }
			 }
			 return null ;
		}
		/**
		 * 初始化界面
		 */
		private function initUI() :void
		{
			cutdownTimer = new CutdownTimer(cutdownMc);
			cutdownTimer.addEventListener(CutdownTimer.OVER, gameOver) ;
			cutdownTimer.addEventListener(CutdownTimer.RUNNING, gameRunning) ;
			cutdownTimer.start(10) ;
			
			
		}
		/**
		 * 游戏 中
		 */
		private function gameRunning(evt : Event) : void
		{
			//trace("gameRunning=================="); 
		}
		/**
		 * 游戏结束
		 */
		private function gameOver(evt : Event)  :void
		{
			trace("gameOver======================");
		}
		//
		public function get gamingData() : Array 
		{
			return _gamingData as Array ;
		}
		//选中区域开始模块
		public function get startBlocky() : Blocky 
		{
			return _startBlocky as Blocky ;
		}
		//选中区域结束模块
		public function get endBlocky() : Blocky
		{
			return _endBlocky as Blocky ;
		}
	}
}
