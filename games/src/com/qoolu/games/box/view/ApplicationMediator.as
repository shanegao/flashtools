package com.qoolu.games.box.view {
	import flash.events.MouseEvent;	
	
	import fl.controls.Button;	
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.model.LevelDataProxy;
	import com.qoolu.games.box.model.RoleDataProxy;
	import com.qoolu.games.box.view.components.BoxesUI;
	import com.qoolu.games.box.view.components.CutdownTimer;		

	/**
	 * @author Gaoxian
	 * ApplicationMediator @ BoxMain
	 */
	public class ApplicationMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = 'ApplicationMediator';
		 
		private var levelDateProxy : LevelDataProxy ;
		private var roleDataProxy : RoleDataProxy ;

		/**
         * Constructor 
         */
		public function ApplicationMediator(viewComponent : Object) 
		{
			super(NAME , viewComponent);
			
			levelDateProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			
			roleDataProxy = facade.retrieveProxy(RoleDataProxy.NAME) as RoleDataProxy ;
			
			//
			var btn : Button = new Button ;
			main.addChild(btn) ;
			btn.addEventListener(MouseEvent.CLICK, onClick) ;
		}
		private function onClick(evt : MouseEvent) :void
		{
			sendNotification(ApplicationFacade.START_GAME , levelDateProxy.level);
			main.removeChild(evt.target as Button) ;
		}
		/**
		 * main
		 */
		protected function get main():BoxMain
		{
            return viewComponent as BoxMain;
		}
		
		override public function listNotificationInterests():Array 
        {
            return [
            		 ApplicationFacade.START_GAME
            		];
        }
        
        
        override public function handleNotification( note : INotification ) : void 
        {
            switch (note.getName() ) 
            {
                case ApplicationFacade.START_GAME : 
					trace(ApplicationFacade.START_GAME);
					//var level:int = note.getBody() as int;
					//trace(params);
					var numOfRole : int = levelDateProxy.numOfRole() as int ;
                	var numOfBox : Array = levelDateProxy.numOfBox();
                	var roles: Array = roleDataProxy.rolesInCurrentLevel(numOfRole);
					var boxes : BoxesUI = new BoxesUI(numOfBox ,roles );
					facade.registerMediator(new BoxesMediator());
					main.addChild(boxes);
					
					var timer : CutdownTimer = new CutdownTimer();
					timer.y = main.stage.stageHeight - timer.height ;
					facade.registerMediator(new CutdownMediator(timer));
					timer.start(10);
					main.addChild(timer) ;
					break ;
				case ApplicationFacade.UPGRADE  :
					trace("ApplicationFacade.UPGRADE " + note.getBody());
					break ;	
            }
        }
	}
}
