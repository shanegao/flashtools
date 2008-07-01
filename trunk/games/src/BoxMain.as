/*
 PureMVC AS3 / Flash Demo - HelloFlash
 By Cliff Hall <clifford.hall@puremvc.org>
 Copyright(c) 2007-08, Some rights reserved.
 */
package {
	import flash.display.MovieClip;
	
	import com.qoolu.games.box.ApplicationFacade;		

	public class BoxMain extends MovieClip
	{
		public function BoxMain()
		{
			ApplicationFacade.getInstance().startup( this.stage );
		}
	}
}
