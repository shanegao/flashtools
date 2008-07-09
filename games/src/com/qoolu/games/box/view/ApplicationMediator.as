package com.qoolu.games.box.view {
	import com.qoolu.games.box.view.components.GameOverUI;	
	
	import flash.display.Sprite;	
	import flash.display.MovieClip;	
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
		private var blockyDataProxy : BlockyDataProxy ;

		/**
         * Constructor 
         */
		public function ApplicationMediator(viewComponent : Object) 
		{
			super(NAME , viewComponent);
			
			levelDateProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			
			blockyDataProxy = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
			
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
            		 ApplicationFacade.GAME_GUIDE ,
            		 ApplicationFacade.GAME_OVER ,
            		 ApplicationFacade.STARTUP ,
            		 ApplicationFacade.RESTART_GAME
            		 ];
		}
        
        
        override public function handleNotification( note : INotification ) : void 
        {
            switch (note.getName()) 
            {
            	case ApplicationFacade.STARTUP : 
            		main.addChild(main.preview);
					break ;
                case ApplicationFacade.START_GAME : 
					//trace(ApplicationFacade.START_GAME);
					//var level:int = note.getBody() as int;
					//trace(params);
					var numOfRole : int = levelDateProxy.numOfRole() as int ;
                	var numOfBox : Array = levelDateProxy.numOfBox();
                	var roles: Array = blockyDataProxy.rolesInCurrentLevel(numOfRole);
                	blockyDataProxy.roles = roles ;
					//var target : PreviewUI = note.getBody() as PreviewUI ;
					//if(target.parent != null) main.removeChild(target) ;
					removeTargetInMain(main.preview);
					removeTargetInMain(main.guideUI);
					facade.registerMediator(new GamingUIMediator(main.gamingUI));
					main.gamingUI.build(numOfBox ,roles );
					main.addChild(main.gamingUI) ;
					break ;
				case ApplicationFacade.GAME_GUIDE :
					trace("ApplicationFacade.GAME_GUIDE " + ApplicationFacade.GAME_GUIDE);	
					removeTargetInMain(main.preview);
					main.addChild(main.guideUI) ;
					main.guideUI.addEventListener(GuideUI.START, startGame) ;
					break ;
				case ApplicationFacade.GAME_OVER : 
					removeTargetInMain(main.gamingUI);
					main.addChild(main.gameOverUI);
					main.gameOverUI.showScore(note.getBody() as int) ;
					main.gameOverUI.addEventListener(GameOverUI.SUBMIT, onSubmint) ;
					break ;	
            }
        }
        /**
         * 把指定目标从主显示列表中删除
         */
        private function removeTargetInMain(tar : Sprite) : void 
        {
        	if(tar != null && main.contains(tar)) main.removeChild(tar);
        }
        
        private function onSubmint(evt : Event)  :void
        {
        	main.addChild(main.preview);
		}
	}
}
