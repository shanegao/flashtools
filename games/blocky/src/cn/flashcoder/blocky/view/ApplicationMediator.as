package cn.flashcoder.blocky.view 
{
	import cn.flashcoder.blocky.ApplicationFacade;
	import cn.flashcoder.blocky.model.BlockyDataProxy;
	import cn.flashcoder.blocky.model.LevelDataProxy;
	import cn.flashcoder.blocky.view.components.GameOverUI;
	import cn.flashcoder.blocky.view.components.GuideUI;
	import cn.flashcoder.blocky.view.components.PreviewUI;
	import cn.flashcoder.blocky.view.components.manager.SoundManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	

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
			//initPreview();
		}
		/**
		 * 添加preview侦听
		 */
		override public function onRegister():void
		{
			levelDateProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			blockyDataProxy = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
			main.preview.addEventListener(PreviewUI.START, startGame) ;
			main.preview.addEventListener(PreviewUI.GUIDE, gameGuide) ;
		}
		/**
		 * 开始游戏
		 */
		private function startGame(evt : Event) : void 
		{
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
					startGameHandler();
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
					main.gameOverUI.addEventListener(GameOverUI.SUBMIT, onSubmit) ;
					SoundManager.play(SoundManager.GAME_OVER);
					break ;	
				case ApplicationFacade.RESTART_GAME : 
					levelDateProxy.level = 1 ;
					startGameHandler();
					break ;	
            }
        }
        
        private function startGameHandler() : void
        {
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
			SoundManager.play(SoundManager.INIT_LEVEL);
        }
        /**
         * 把指定目标从主显示列表中删除
         */
        private function removeTargetInMain(tar : Sprite) : void 
        {
        	if(tar != null && main.contains(tar)) main.removeChild(tar);
        }
        
        private function onSubmit(evt : Event)  :void
        {
        	sendNotification(ApplicationFacade.RESTART_GAME) ;
		}
	}
}
