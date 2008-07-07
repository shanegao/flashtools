package com.qoolu.games.box.view.components {
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
		public var boardMc : MovieClip ;
		public var scoreMc : MovieClip ;
		public var cutdownMc : MovieClip ;
		
		private var cutdownTimer : CutdownTimer ;
		private var container : Sprite ;
		private var startDraw : Boolean ;
		
		private var gamingData : Array  ;
		private var border : Sprite ;
		public function GamingUI()
		{
			trace("GamingUI created ! " + boardMc.name);
			gamingData = [];
			container = new Sprite() ;
			initUI();
		}
		/**
		 * 创建方块
		 */
		public function build(nums : Array, roles:Array) : void
		{
			trace(nums , roles);
			var wNum : int = nums[0] as int ;
			var hNum : int = nums[1] as int ;

			var itemW : Number = Math.floor(boardMc.width / wNum);
			var itemH : Number = Math.floor(boardMc.height / hNum); 
						
			for(var i : int = 0 ; i <wNum ; i++)
			{
				var xx : Number = i * itemW ;
				gamingData[i] = [] ; 
				for(var j : int = 0 ; j < hNum ; j++)
				{
					var blocky : String  = roles[Math.floor(Math.random()* roles.length)] as String; 
					var item : Blocky = BlockyManager.createBlocky(blocky) as Blocky;
					item.name = "blocky_"+i+"_"+j ;
					item.x = xx ;
					item.y = itemH * j ;
					item.width = itemW - 1 ;
					item.height = itemH - 1 ;
					boardMc.addChild(item);
					gamingData[i][j] = item.name ;
					initBlocky(item);
					//trace("gamingData  : " + gamingData[i][j]);
				}
			}
			boardMc.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler) ;
		
		}

		/**
		 * 初始化方块信息
		 */
		private function initBlocky(item : Blocky)  :void
		{
			item.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler) ;
			item.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler) ;
			item.addEventListener(MouseEvent.ROLL_OVER, rollOver) ;
		}
		
		private function mouseUpHandler(evt : MouseEvent) : void
		{
			if(border != null && boardMc.contains(border)) boardMc.removeChild(border);
			startDraw = false ;
		}
		
		private function mouseDownHandler(evt : MouseEvent) : void
		{
			startDraw = true ;
			var t : Blocky = evt.currentTarget as Blocky ;
			border = new Sprite();
			boardMc.addChild(border) ;
			border.graphics.lineStyle(2,0xFF0000);
			border.graphics.drawRect(0, 0, t.width, t.height);
			border.x = t.x + 1 ;
			border.y = t.y + 1 ;
		}
		
		private function rollOver(	evt : MouseEvent) : void
		{
			
		}
		
		/**
		 * 鼠标移动
		 */
		private function mouseMoveHandler(evt : MouseEvent) : void 
		{
			if(startDraw)
			{
				 //trace(evt.localX , evt.localY);
				 var nowX : Number = Number(evt.localX) ;
				 var nowY : Number = Number(evt.localY) ;
				 mainLoop: for(var i : int = 0 ; i< gamingData.length ;i++)
				 {
					for(var j : int = 0 ; j <gamingData[i].length ; i++)
				 	{
				 		var item : Blocky = boardMc.getChildByName(gamingData[i][j] as String) as Blocky ;
				 		if(item.x <= nowX && item.x +item.width >= nowX && item.y <= nowY && item.y +item.height >= nowY)
				 		{
				 			trace("move : " + item.name);
				 			border.graphics.clear();
				 			border.graphics.lineStyle(2,0xFF0000);
				 			border.graphics.drawRect(0, 0,item.x +item.width, item.y +item.height);
							//border.x = t.x + 1 ;
							//border.y = t.y + 1 ;
									 		
				 			break mainLoop;	
				 		}	
				 				
				 	}
				 }
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
			cutdownTimer.start(10) ;
			
			
		}
		/**
		 * 游戏 中
		 */
		private function gameRunning(evt : Event) : void
		{
			trace("gameRunning=================="); 
		}
		/**
		 * 游戏结束
		 */
		private function gameOver(evt : Event)  :void
		{
			trace("gameOver======================");
		}
		
		
	}
}
