package com.qoolu.games.box.model 
{
	import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
	/**
	 * 等级数据
	 * @author Gaoxian
	 */
    public class LevelDataProxy extends Proxy implements IProxy
    {
        public static const NAME:String = 'LevelDataProxy';
        
		public static var CURRENT_LEVEL : int = 0 ;
        
        public function LevelDataProxy( )
        {
            super( NAME, Number(0) );
        }	
		/**
		 	关卡数量设计
			第一关为5×5个方格
			第二关为8×8个方格
			第三关为10×10个方格
			第四关为12×12个方格
			此后均为16×16个方格
		 */
		 public function numOfBox() : Array
		 {
		 	if(CURRENT_LEVEL == 1) return [5 , 5] ;
		 	if(CURRENT_LEVEL == 2) return [8 , 8] ;
		 	if(CURRENT_LEVEL == 3) return [10 ,10] ;
		 	if(CURRENT_LEVEL == 4) return [12 , 12] ;
		 	if(CURRENT_LEVEL > 4) return [16 , 16];
		 	
		 }
		/**
		 * 第一关两种颜色
			第二关两种颜色
			第三关三种颜色
			第四关四种颜色
			第五关五种颜色
			第六关六种颜色
			此后均为八种颜色
		 */ 
		public function numOfRole() : int
		{
			if(CURRENT_LEVEL == 1 || CURRENT_LEVEL == 2) return 2 ;
			if(CURRENT_LEVEL == 3) return 3 ;
			if(CURRENT_LEVEL == 4) return 4 ;
			if(CURRENT_LEVEL == 5) return 5 ;
			if(CURRENT_LEVEL == 6) return 6 ;
			if(CURRENT_LEVEL > 6) return 8 ;
    	}
    	/**
    	 * 
    	 * 4.记分规则
		 *	每次消4×4个方块以下（包括4×4），每消1个方块得2分
		 *	每次消8×8个方块以下（包括8×8），每消1个方块得5分
		 *	每次消12×12个方块以下（包括12×12），每消1个方块得10分
		 *	每次消16×16个方块以下（包括16×16），每消1个方块得50分
		 *	
    	 */
    	 
    	 public function scoreOfFight(numW : int , numH :int ) : int
    	 {
    	 	if(numW<= 4 ||numH <= 4) return 2 ;
    	 	if(numW<= 8 ||numH <= 8) return 5 ;
    	 	if(numW<= 12 || numH <= 12) return 10 ;
    	 	if(numW<= 16 || numH <= 16) return 50 ;
    	 }
    	
    }
}