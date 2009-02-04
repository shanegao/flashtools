package {
	import flash.display.MovieClip;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.view.components.GameOverUI;
	import com.qoolu.games.box.view.components.GamingUI;
	import com.qoolu.games.box.view.components.GuideUI;
	import com.qoolu.games.box.view.components.PreviewUI;		

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
