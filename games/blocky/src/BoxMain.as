package {
	import cn.flashcoder.blocky.ApplicationFacade;
	import cn.flashcoder.blocky.view.components.GameOverUI;
	import cn.flashcoder.blocky.view.components.GamingUI;
	import cn.flashcoder.blocky.view.components.GuideUI;
	import cn.flashcoder.blocky.view.components.PreviewUI;
	
	import flash.display.MovieClip;
	
	
	public class BoxMain extends MovieClip
	{
		public var preview : PreviewUI ;
		public var gamingUI : GamingUI ;
		public var guideUI : GuideUI ;
		public var gameOverUI : GameOverUI ;

		public function BoxMain() 
		{
			preview = new PreviewUI();
			gamingUI = new GamingUI();
			guideUI = new GuideUI();
			gameOverUI = new GameOverUI();
			ApplicationFacade.getInstance("blocky").startup(this) ;
		}
	}
}
