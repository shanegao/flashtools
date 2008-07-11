package com.qoolu.games.box.view {
	import com.qoolu.games.box.view.components.manager.SoundManager;	
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.model.BlockyDataProxy;
	import com.qoolu.games.box.model.LevelDataProxy;
	import com.qoolu.games.box.model.ScoreDataProxy;
	import com.qoolu.games.box.view.components.GamingUI;
	import com.qoolu.games.box.view.components.blockys.Blocky;		

	/**
	 * @author Gaoxian
	 */
	public class GamingUIMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "GamingUIMediator";
		
		private var blockyData : BlockyDataProxy ;
		private var scoreData : ScoreDataProxy ;

		public function GamingUIMediator(viewComponent : Object) 
		{
			super(NAME, viewComponent);
		
			blockyData = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
			scoreData  = facade.retrieveProxy(ScoreDataProxy.NAME) as ScoreDataProxy ;
			
			blockies.addEventListener(GamingUI.SELECTED, onUserSelect)	 ;
			blockies.addEventListener(GamingUI.BUILD_COMPLETE, onBuildComplete) ;
			blockies.addEventListener(GamingUI.GAME_OVER, onGameOver);
			blockies.addEventListener(GamingUI.SCORE_DESTROY, onDestroy) ;
		}
		
		private function onDestroy(evt : Event)  :void
		{
			trace("^^^^^^^^^^^^^^^^^^0");
			sendNotification(ApplicationFacade.CHECK_UPGRADE);
		}
		/**
		 * 创建方块完成事件处理
		 */
		private function onBuildComplete(evt : Event)  : void
		{
			var tar : GamingUI = evt.target as GamingUI ;
			blockyData.blockyArray = tar.gamingData as Array ;
		}
		/**
		 * 用户选择区域事件处理
		 */
		private function onUserSelect(evt : Event) : void
		{
			var tar : GamingUI = evt.target as GamingUI ;
			sendNotification(ApplicationFacade.USER_SELECT , [tar.startBlocky,tar.endBlocky]) ;
		}
		/**
		 * 时间到，游戏结束
		 */
		private function onGameOver(evt : Event)  :void
		{
			sendNotification(ApplicationFacade.GAME_OVER,scoreData.totalScore);
		}
		
		/**
		 * 得到gamingUI
		 */
		public function get blockies() : GamingUI 
		{
			return viewComponent as GamingUI ;
		}
		
		override public function listNotificationInterests():Array 
        {
            return [
            		 ApplicationFacade.RE_DRAW ,
            		 ApplicationFacade.UPGRADE ,
            		 ApplicationFacade.ADD_SCORE,
            		 ApplicationFacade.REMOVE_BLANK,
            		 ApplicationFacade.REMOVE_FAIL
            		 ];
		}
        
        
        override public function handleNotification( note : INotification ) : void 
        {
        	switch(note.getName())
        	{
        		case ApplicationFacade.RE_DRAW : 
        			trace("re draw.......................") ;
        			var blocky : Blocky = note.getBody() as Blocky ;
        			//if(blocky.hasPet) blocky.removePet();
					blockies.createBlocky(blocky.pos[0] , blocky.pos[1]);
        			break ;
        		case ApplicationFacade.UPGRADE :
        			var levelData : LevelDataProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
					var blockyData : BlockyDataProxy = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
					var numOfRole : int = levelData.numOfRole() as int ;
            		var numOfBox : Array = levelData.numOfBox();
           	 		var roles: Array = blockyData.rolesInCurrentLevel(numOfRole);
            		blockyData.roles = roles ;
        			blockies.build(numOfBox, roles);
        			blockies.levelTxt.text ="level: "+ levelData.level.toString() ;
        			//播放初始化声音
					SoundManager.play(SoundManager.INIT_LEVEL);
					break ;	
        		case ApplicationFacade.ADD_SCORE : 
        			blockies.score = scoreData.totalScore ;
        			blockies.scoreThisTime = scoreData.scoreOfThisTime ;
					SoundManager.play(SoundManager.REMOVE_PET);
					break ;	
        		case ApplicationFacade.REMOVE_BLANK:
        			SoundManager.play(SoundManager.REMOVE_BLANK);
					break ;	
        		case ApplicationFacade.REMOVE_FAIL :
        			SoundManager.play(SoundManager.FAIL_REMOVE);
					break ;
        	}
        }
	}
}
