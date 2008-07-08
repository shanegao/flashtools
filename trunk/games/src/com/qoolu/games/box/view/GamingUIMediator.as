package com.qoolu.games.box.view {
	import com.qoolu.games.box.ApplicationFacade;	
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import com.qoolu.games.box.model.BlockyDataProxy;
	import com.qoolu.games.box.view.components.GamingUI;		

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
			trace("gmaingData : " , tar.gamingData[0]) ;
			trace("onBuildComplete");
		}
		/**
		 * 
		 */
		private function onUserSelect(evt : Event) : void
		{
			var tar : GamingUI = evt.target as GamingUI ;
			//trace("onUserSelect : " +  tar.startBlocky.name , tar.endBlocky.name);
			//trace(tar.startBlocky.color);
			sendNotification(ApplicationFacade.USER_SELECT , [tar.startBlocky,tar.endBlocky]) ;
		}

		public function get blockies() : GamingUI 
		{
			return viewComponent as GamingUI ;
		}
	}
}
