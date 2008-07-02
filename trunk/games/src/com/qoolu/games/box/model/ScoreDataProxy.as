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
		
		public static var TOTAL_SCORE : int = 0 ;		
		public function ScoreDataProxy() 
		{
			super( NAME );
		}
		
		public function totalScore() : int
		{
			//TOTAL_SCORE
			return ;
		}
	}
}
