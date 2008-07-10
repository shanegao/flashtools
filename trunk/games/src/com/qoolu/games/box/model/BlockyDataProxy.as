package com.qoolu.games.box.model {
	import com.qoolu.games.box.ApplicationFacade;	
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import com.qoolu.games.box.view.components.blockys.Blocky;		

	/**
	 * 角色数据
	 * @author Gaoxian
	 */
	public class BlockyDataProxy extends Proxy implements IProxy 
	{
		public static const NAME : String = "RoleDataProxy";
		
		private var roleArray : Array ;
		
		private var RED : String = "RedBlocky";
		private var BLUE : String = "BlueBlocky";
		private var DEEP_BLUE : String = "DeepBlueBlocky" ;
		private var YELLOW  : String = "YellowBlocky" ;
		private var GREEN : String = "GreenBlocky";
		private var PURPLE : String = "PurpleBlocky" ;
		private var PINK : String = "PinkBlocky";
		private var GREY : String = "GreyBlocky";
		
		private var  _blockyArray : Array ;
		private var _roles : Array ;
		public function BlockyDataProxy () 
		{
			super(NAME);
			roleArray = [RED , BLUE, DEEP_BLUE , YELLOW , GREEN , PURPLE ,PINK , GREY];
		}
		/**
		 * 得到当前级别的角色个数
		 */
		public function rolesInCurrentLevel (numOfRole : int) : Array
		{
			//var levelData : LevelDataProxy = new LevelDataProxy() ; 
			//var num :int = levelData.numOfRole();
			return fetchUniqItem(roleArray, numOfRole);
		} 
		/**
		 * 在目标数组中，取出指定个数不重复索引的元素。。。。
		 * @param src 目标数组 
		 * @param num 要得到的元素个数
		 */
		private function fetchUniqItem(src :Array , num : int) : Array
		{
			var targetArr : Array = src.concat() ;
			var arr : Array = [];
			for (var i :int = 0; i <num; i++) 
			{
				var index : int = Math.floor(Math.random() * targetArr.length);
				arr.push(targetArr[index]);
				targetArr.splice(index,1);
			}
			return arr;
		}
		/**
		 * 用户设定选中区域
		 */
		public function userSelect(start :Blocky , end : Blocky) : void
		{
			trace("BlockyDataProxy : " + start.color,end.color);
			trace(start.pos , end.pos);
			var s : Array = start.pos as Array ;
			var e : Array = end.pos as Array ;
			
			var tl : Blocky = start ;
			var tr : Blocky = blockyArray[e[0]][s[1]] as Blocky ;
			var br : Blocky = end ; 
			var bl : Blocky = blockyArray[s[0]][e[1]] as Blocky ;
			trace(tl.color,tr.color,br.color,bl.color);
			
			var distroyNum : Number = 0 ;
			if(tl.color == tr.color && tl.color == br.color && tl.color == bl.color)
			{
				var x1 : int = s[0] > e[0] ? e[0] : s[0] ;
				var x2 : int = s[0] < e[0] ? e[0] : s[0] ;
				var x3 : int = s[1] > e[1] ? e[1] : s[1] ;
				var x4 : int = s[1] < e[1] ? e[1] : s[1] ;
				for	(var i : int= x1 ;i<= x2 ;i++)
				{
					for(var j : int= x3 ;j<= x4 ; j++)
					{
						var item : Blocky = blockyArray[i][j] as Blocky ;
						trace(i,j," select items : " + item.name);
						if(item.hasPet) distroyNum++;
						sendNotification(ApplicationFacade.RE_DRAW , item);
					}
				}
				trace("消除了。。。" + distroyNum + " 个方块笑脸 。。。");	
				if(distroyNum ==0)	{sendNotification(ApplicationFacade.REMOVE_BLANK) ; return;}
				sendNotification(ApplicationFacade.ADD_SCORE,[distroyNum,x2-x1,x4-x3]);
				//检查是否全部消除
				for(var m : int = 0 ; m< blockyArray.length ;m++)
			 	{
					for(var n : int = 0 ; n <blockyArray[m].length ; n++)
					{
						var blocky : Blocky = blockyArray[m][n] as Blocky ;
						if(blocky.hasPet) return ;
					 }
			 	}
			 	sendNotification(ApplicationFacade.UPGRADE);
			}
			else sendNotification(ApplicationFacade.REMOVE_FAIL);
		}
		/**
		 * 当前游戏中的方块信息数据
		 */
		public function set blockyArray(arr : Array)  :void
		{
			_blockyArray = arr ; 
		}
		public function get blockyArray()  :Array 
		{
			return _blockyArray as Array;
		}
		/**
		 * 当前游戏中的方块信息数据
		 */
		public function set roles(arr : Array)  :void
		{
			_roles = arr ; 
		}
		public function get roles()  :Array 
		{
			return _roles as Array;
		}
	}
}
