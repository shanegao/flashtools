package com.qoolu.games.box.model {
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.interfaces.IProxy;
	
	/**
	 * 得分数据
	 * @author Gaoxian
	 */
	public class ScoreDataProxy extends Proxy implements IProxy 
	{
		public static const NAME : String = "ScoreDataProxy";
		
		private var _totalScore : int = 0 ;		
		public function ScoreDataProxy() 
		{
			super( NAME );
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
    	 private function scoreOfItem(numW : int , numH :int ) : int
    	 {
    	 	if(numW<= 4 ||numH <= 4) return 2 ;
    	 	if(numW<= 8 ||numH <= 8) return 5 ;
    	 	if(numW<= 12 || numH <= 12) return 10 ;
    	 	if(numW<= 16 || numH <= 16) return 50 ;
    	 	return 2 ;
    	 }
    	/**
    	 * 添加相应的分数
    	 * @param distroyNum 消除的笑脸个数
    	 * @param numH 消除时的框高
    	 * @param numW 消除时的框宽
    	 */
    	public function addScore(distroyNum : int ,numW : int , numH :int) : void
    	{
    		_totalScore += distroyNum  * scoreOfItem(numW , numH) ;
    	}
    	/**
    	 * getter
    	 */
		public function get totalScore() : int
		{
			return _totalScore;
		}
		/**
		 * setter 
		 */
		public function set totalScore(_score : int) : void
		{
			_totalScore = _score ;
		}
	}
}
