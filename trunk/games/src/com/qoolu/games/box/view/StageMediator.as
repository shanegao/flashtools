package com.qoolu.games.box.view {
	import com.qoolu.games.box.view.components.CutdownTimer;	
	import com.qoolu.games.box.view.components.BoxesUI;	
	import com.qoolu.games.box.model.LevelDataProxy;	
	
	import org.puremvc.as3.interfaces.INotification;	
	
	import com.qoolu.games.box.ApplicationFacade;	
	
	import flash.display.Stage;	
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.observer.Notifier;	

	/**
	 * @author Gaoxian
	 * 
	 */
	public class StageMediator extends Mediator implements IMediator 
	{
		 public static const NAME:String = 'StageMediator';
		 
		 private var levelDateProxy : LevelDataProxy ;

		/**
         * Constructor 
         */
		public function StageMediator(viewComponent : Object) 
		{
			super(NAME , viewComponent);
			
			levelDateProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
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
					//var params:Array = note.getBody() as Array;
					//trace(params);
                	var boxes : BoxesUI = new BoxesUI(levelDateProxy.numOfBox());
					facade.registerMediator(new BoxesMediator());
					stage.addChild(boxes);
					
					var timer : CutdownTimer = new CutdownTimer();
					timer.y = stage.stageHeight - timer.height ;
					facade.registerMediator(new CutdownMediator(timer));
					timer.start(10);
					stage.addChild(timer) ;
					break ;
            }
        }
	}
}
