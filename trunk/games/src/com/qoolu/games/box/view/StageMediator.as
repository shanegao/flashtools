package com.qoolu.games.box.view {
	import flash.display.Stage;	
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	
	/**
	 * @author Gaoxian
	 * 
	 */
	public class StageMediator extends Mediator implements IMediator 
	{
		 public static const NAME:String = 'StageMediator';
        /**
         * Constructor. 
         */
		public function StageMediator(viewComponent : Object) 
		{
			super(NAME , viewComponent);
			
			
		}
		
		/**
		 * stage
		 */
		protected function get stage():Stage
		{
            return viewComponent as Stage;
		}
	}
}
