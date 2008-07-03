package com.qoolu.games.box.view {
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	
	/**
	 * @author Gaoxian
	 */
	public class BoxesMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "BoxesMediator";
		
		public function BoxesMediator(viewComponent : Object = null) 
		{
			super(NAME, viewComponent);
		}
		
	}
}
