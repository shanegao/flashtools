package com.qoolu.games.box.view {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.view.components.CutdownTimer;		

	/**
	 * @author Gaoxian
	 */
	public class CutdownMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "CutdownMediator";
		
		
		public function CutdownMediator(viewComponent: Object) 
		{
			super(NAME , viewComponent);
			
			cutdownTimer.addEventListener(CutdownTimer.OVER, onTimeOver);
			cutdownTimer.addEventListener(CutdownTimer.RUNNING, onTimeRunning);
		}
		/**
		 * 计时中
		 */
		private function onTimeRunning (evt : Event) : void
		{
			trace("onTimeRunning") ;
		}
	
		/**
		 * 计时结束
		 */      
        private function onTimeOver(evt : Event) : void
        {
        	trace("onTimeOver") ;
        	sendNotification(ApplicationFacade.UPGRADE);
        	//sendNotification(ApplicationFacade.GAME_OVER);
        }
		/**
		 * 得到实例
		 */
		protected function get cutdownTimer() : CutdownTimer 
		{
            return viewComponent as CutdownTimer;
        }
        
      	override public function listNotificationInterests():Array 
        {
            return [
            		 ApplicationFacade.GAME_OVER,
            		 ];
        }
        
        
        override public function handleNotification( note : INotification ) : void 
        {
            switch (note.getName() ) 
            {
                case ApplicationFacade.GAME_OVER : 
                	//do somethings ....
                	trace("Game over @ CutdownMediator " );
					break ;
            }
        }
		
  
	}
}
