package {
	import flash.display.MovieClip;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.view.components.PreviewUI;		

	public class BoxMain extends MovieClip
	{
		public var preview : PreviewUI ;

		public function BoxMain()
		{
			ApplicationFacade.getInstance().startup( this );
		}
	}
}
