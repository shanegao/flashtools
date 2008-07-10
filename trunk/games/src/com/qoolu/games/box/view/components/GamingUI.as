package com.qoolu.games.box.view.components {
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	
	import com.qoolu.games.box.ApplicationFacade;	
	
	import flash.text.TextFieldAutoSize;	
	import flash.text.TextField;	
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
		public static const GAME_OVER : String = "gameOver.....";
		
		private var borderColor :uint = 0xFFFFFF;
		private var borderTS : int = 3 ;
		
		public var boardMc : MovieClip ;
		public var scoreMc : MovieClip ;
		public var cutdownMc : MovieClip ;
		public var levelTxt : TextField ;
		
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
		
		private var petTimer : Timer ;
		private var intervalTime : int =0 ;
		public function GamingUI()
		{
			trace("GamingUI created ! " + boardMc.name);
			initUI();
			intervalTime =  Math.floor(Math.random() * 5 + 2) *1000 ;
			petTimer = new Timer(intervalTime);
			petTimer.addEventListener(TimerEvent.TIMER, petSimle);
			
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

			itemW = boardMc.width / wNum ;
			itemH = boardMc.height / hNum ; 
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
			
			cutdownTimer.start(ApplicationFacade.TIMER_REPEAT) ;
			//
			petTimer.reset();
			petTimer.repeatCount = intervalTime ;
			petTimer.start();
			
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
			if(endBlocky == null ||startBlocky == endBlocky || startBlocky.pos[0] == endBlocky.pos[0]
			|| startBlocky.pos[1] == endBlocky.pos[1]) return ;
			dispatchEvent(new Event(SELECTED)) ;
			_startBlocky = null ;
			_endBlocky = null ;
			
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
			border.graphics.lineStyle(borderTS , borderColor);
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
				
				border.graphics.clear();
				border.graphics.lineStyle( borderTS , borderColor);
				border.graphics.drawRect(0, 0, borderW, borderH );
				border.x = startX ;
				border.y = startY ;
				//
				_endBlocky = t ;				
			}
		}
		/**
		 * 随机的时间内随机个数方块闪动
		 * @param nowX x坐标
		 * @param nowY y坐标
		 */
		private function petSimle(evt : TimerEvent) : void
		{
			var allPetArray : Array = [];
			 for(var i : int = 0 ; i< _gamingData.length ;i++)
			 {
				for(var j : int = 0 ; j <_gamingData[i].length ; j++)
				{
					allPetArray.push(_gamingData[i][j] as Blocky );
				}
			 }
			 //
			if(allPetArray.length == 0) return  ;
			var nums:  Number = Math.floor(Math.random() * 3 + 2) ;
			while(nums -- >0)
			{
				var item : Blocky = allPetArray[Math.floor(Math.random() * allPetArray.length)] as Blocky ;
				item.pet.play();
			} 
		}
		/**
		 * 初始化界面
		 */
		private function initUI() :void
		{
			cutdownTimer = new CutdownTimer(cutdownMc);
			cutdownTimer.addEventListener(CutdownTimer.OVER, gameOver) ;
			cutdownTimer.addEventListener(CutdownTimer.RUNNING, gameRunning) ;
		}
		/**
		 * 得分
		 */
		public function set score(value : int) :void 
		{
			var txt : TextField = scoreMc["scoreTxt"] as TextField ;
			txt.text = value.toString();
			txt.autoSize = TextFieldAutoSize.LEFT ;
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
			dispatchEvent(new Event(GAME_OVER));
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
