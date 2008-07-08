package com.qoolu.games.box.view {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.model.BlockyDataProxy;
	import com.qoolu.games.box.model.LevelDataProxy;
	import com.qoolu.games.box.view.components.GamingUI;
	import com.qoolu.games.box.view.components.blockys.Blocky;		

	/**
	 * @author Gaoxian
	 */
	public class GamingUIMediator extends Mediator implements IMediator 
	{
		public static const NAME : String = "GamingUIMediator";
		
		private var blockyData : BlockyDataProxy ;

		public function GamingUIMediator(viewComponent : Object) 
		{
			super(NAME, viewComponent);
		
			blockyData = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
			
			blockies.addEventListener(GamingUI.SELECTED, onUserSelect)	 ;
			blockies.addEventListener(GamingUI.BUILD_COMPLETE, onBuildComplete) ;
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
            		 ApplicationFacade.RESTART_GAME
            		 ];
		}
        
        
        override public function handleNotification( note : INotification ) : void 
        {
        	switch(note.getName())
        	{
        		case ApplicationFacade.RE_DRAW : 
        			trace("re draw.......................") ;
        			var blocky : Blocky = note.getBody() as Blocky ;
        			if(blocky.hasPet) blocky.removePet();
					blockies.createBlocky(blocky.pos[0] , blocky.pos[1]);
        			break ;
        		case ApplicationFacade.RESTART_GAME :
        			var level : LevelDataProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
					var blockyData : BlockyDataProxy = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
					var numOfRole : int = level.numOfRole() as int ;
            		var numOfBox : Array = level.numOfBox();
           	 		var roles: Array = blockyData.rolesInCurrentLevel(numOfRole);
            		blockyData.roles = roles ;
        			blockies.build(numOfBox, roles);
        			trace("restart game ..........");
        			break ;	
        	}
        }
	}
}
