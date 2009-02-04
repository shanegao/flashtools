package cn.flashcoder.blocky.model
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;	

	/**
	 * 等级数据
	 * @author Gaoxian
	 */
    public class LevelDataProxy extends Proxy implements IProxy
    {
        public static const NAME:String = 'LevelDataProxy';
        
		private var _level : int = 1 ;
        
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
		 	if(_level == 1) return [5 , 5] ;
		 	if(_level == 2) return [6 , 6] ;
		 	if(_level == 3) return [7 ,7] ;
		 	if(_level == 4) return [8 , 8] ;
		 	if(_level == 5) return [9 , 9] ;
		 	if(_level == 6) return [10 , 10] ;
		 	if(_level == 7) return [11 ,11] ;
		 	if(_level == 8) return [12 , 12] ;
		 	if(_level == 9) return [13 , 13] ;
		 	if(_level == 10) return [14 , 14] ;
		 	if(_level == 11) return [15 ,15] ;
		 	if(_level >= 12) return [16 , 16] ;
		 	return [5,5];
		 }
		/**
		第一关两种颜色
		第二关两种颜色
		第三关三种颜色
		第4关四种颜色
		第8关五种颜色
		第12关六种颜色
		此后均为八种颜色
		 */ 
		public function numOfRole() : int
		{
			if(_level == 1 || _level == 2) return 2 ;
			if(_level == 3) return 3 ;
			if(_level >= 4 && _level < 8) return 4 ;
			if(_level >= 8 && _level < 12) return 5 ;
			if(_level == 12) return 6 ;
			if(_level > 12) return 8 ;
			return 2 ;
    	}
    	/**
    	 * 得到当前级别 getter --b
    	 */
    	public function get level() : int 
    	{
			return _level ;
		}
		/**
		 * setter
		 */
		public function set level( _l:int ) : void
		{
			_level = _l ;
		}
		public function levelAdd() :void
		{
			_level ++ ;
		}
    }
}