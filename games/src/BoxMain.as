package {
	import flash.display.MovieClip;
	
	import com.qoolu.games.box.ApplicationFacade;	

	public class BoxMain extends MovieClip
	{
		public var preview : MovieClip ;
		public function BoxMain()
		{
			ApplicationFacade.getInstance().startup( this );
		}
	}
}
