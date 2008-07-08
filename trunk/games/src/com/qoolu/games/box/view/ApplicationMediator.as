package com.qoolu.games.box.view {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.model.BlockyDataProxy;
	import com.qoolu.games.box.model.LevelDataProxy;
	import com.qoolu.games.box.view.components.GamingUI;
	import com.qoolu.games.box.view.components.GuideUI;
	import com.qoolu.games.box.view.components.PreviewUI;		

	/**
	 * @author Gaoxian
	 * ApplicationMediator @ BoxMain
	 */
	public class ApplicationMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = 'ApplicationMediator';
		 
		private var levelDateProxy : LevelDataProxy ;
		private var roleDataProxy : BlockyDataProxy ;

		/**
         * Constructor 
         */
		public function ApplicationMediator(viewComponent : Object) 
		{
			super(NAME , viewComponent);
			
			levelDateProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			
			roleDataProxy = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
			
			initPreview();
			
		}
		/**
		 * 添加preview侦听
		 */
		private function initPreview() : void
		{
			main.preview.addEventListener(PreviewUI.START, startGame) ;
			main.preview.addEventListener(PreviewUI.GUIDE, gameGuide) ;
		}
		/**
		 * 开始游戏
		 */
		private function startGame(evt : Event) : void 
		{
			trace("startgame");
			
			sendNotification(ApplicationFacade.START_GAME , levelDateProxy.level);
		}
		/**
		 * 出现游戏指南
		 */
		private function gameGuide(evt :Event) : void
		{
			sendNotification(ApplicationFacade.GAME_GUIDE, main.preview);
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
            		 ApplicationFacade.START_GAME ,
            		 ApplicationFacade.GAME_GUIDE
            		];
        }
        
        
        override public function handleNotification( note : INotification ) : void 
        {
            switch (note.getName()) 
            {
                case ApplicationFacade.START_GAME : 
					trace(ApplicationFacade.START_GAME);
					//var level:int = note.getBody() as int;
					//trace(params);
					var numOfRole : int = levelDateProxy.numOfRole() as int ;
                	var numOfBox : Array = levelDateProxy.numOfBox();
                	var roles: Array = roleDataProxy.rolesInCurrentLevel(numOfRole);
					//var target : PreviewUI = note.getBody() as PreviewUI ;
					//if(target.parent != null) main.removeChild(target) ;
					if(main.preview != null && main.contains(main.preview)) main.removeChild(main.preview);
					var gaming : GamingUI = new GamingUI();
					gaming.build(numOfBox ,roles );
					main.addChild(gaming) ;
					facade.registerMediator(new GamingUIMediator(gaming));
					//var boxes : BoxesUI = new BoxesUI(numOfBox ,roles );
					//facade.registerMediator(new BoxesMediator());
					//main.addChild(boxes);
					/*
					var timer : CutdownTimer = new CutdownTimer();
					timer.y = main.stage.stageHeight - timer.height ;
					facade.registerMediator(new CutdownMediator(timer));
					timer.start(10);
					main.addChild(timer) ;
					 */
					break ;
				case ApplicationFacade.GAME_GUIDE :
					trace("ApplicationFacade.GAME_GUIDE " + ApplicationFacade.GAME_GUIDE);	
					var target : PreviewUI = note.getBody() as PreviewUI ;
					if(target.parent != null) main.removeChild(target) ;
					var guide  :GuideUI = GuideUI.getInstance() ;
					main.addChild(guide) ;
					guide.addEventListener(GuideUI.START, startGame) ;
					break ;
            }
        }
	}
}
