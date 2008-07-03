package com.qoolu.games.box.view {
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import com.qoolu.games.box.view.components.BoxesUI;		

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
		
		public function rebuild() : void
		{
					
		}
		
		public function get boxes() : BoxesUI 
		{
			return viewComponent as BoxesUI ;
		}
	}
}
