package com.qoolu.games.box.view {
	import flash.display.Stage;
	
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
	 * 
	 */
	public class StageMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = 'StageMediator';
		 
		private var levelDateProxy : LevelDataProxy ;
		private var roleDataProxy : RoleDataProxy ;

		/**
         * Constructor 
         */
		public function StageMediator(viewComponent : Object) 
		{
			super(NAME , viewComponent);
			
			levelDateProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			
			roleDataProxy = facade.retrieveProxy(RoleDataProxy.NAME) as RoleDataProxy ;
		}

		/**
		 * stage
		 */
		protected function get stage():Stage
		{
            return viewComponent as Stage;
		}
		
		override public function listNotificationInterests():Array 
        {
            return [
            		 ApplicationFacade.DEPLOY_UI
            		];
        }
        
        
        override public function handleNotification( note : INotification ) : void 
        {
            switch (note.getName() ) 
            {
                case ApplicationFacade.DEPLOY_UI : 
					trace(ApplicationFacade.DEPLOY_UI);
					//var level:int = note.getBody() as int;
					//trace(params);
					var numOfRole : int = levelDateProxy.numOfRole() as int ;
                	var numOfBox : Array = levelDateProxy.numOfBox();
                	var roles: Array = roleDataProxy.rolesInCurrentLevel(numOfRole);
					var boxes : BoxesUI = new BoxesUI(numOfBox ,roles );
					facade.registerMediator(new BoxesMediator());
					stage.addChild(boxes);
					
					
					
					var timer : CutdownTimer = new CutdownTimer();
					timer.y = stage.stageHeight - timer.height ;
					facade.registerMediator(new CutdownMediator(timer));
					timer.start(10);
					stage.addChild(timer) ;
					break ;
				case ApplicationFacade.UPGRADE  :
					trace("ApplicationFacade.UPGRADE " + note.getBody());
					break ;	
            }
        }
	}
}
