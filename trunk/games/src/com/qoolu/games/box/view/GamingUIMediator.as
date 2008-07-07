package com.qoolu.games.box.view {
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import com.qoolu.games.box.view.components.GamingUI;		

	/**
	 * @author Gaoxian
	 */
	public class GamingUIMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "GamingUIMediator";

		public function GamingUIMediator(viewComponent : Object) 
		{
			super(NAME, viewComponent);
		}

		public function get boxes() : GamingUI 
		{
			return viewComponent as GamingUI ;
		}
	}
}
