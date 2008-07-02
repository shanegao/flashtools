package com.qoolu.games.box.view {
	import com.qoolu.games.box.ApplicationFacade;	
	
	import org.puremvc.as3.interfaces.INotification;	
	
	import flash.events.Event;	
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	
	/**
	 * @author Gaoxian
	 */
	public class CutdownMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "CutdownMediator";
		
		
		public function CutdownMediator() 
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
            		 ApplicationFacade.TIME_OVER,
            	   ];
        }
        
        
        override public function handleNotification( note : INotification ) : void 
        {
            switch (note.getName() ) 
            {
                case ApplicationFacade.TIME_OVER : 
                
                break ;
            }
        }
		
  
	}
}
