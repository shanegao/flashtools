package com.qoolu.games.box.controller {
	import com.qoolu.games.box.model.ScoreDataProxy;	
	import com.qoolu.games.box.model.RoleDataProxy;	
	import com.qoolu.games.box.ApplicationFacade;	
	import com.qoolu.games.box.view.StageMediator;	
	import com.qoolu.games.box.model.LevelDataProxy;	
	
	import flash.display.Stage;	
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notifier;	

	/**
	 * @author Gaoxian
	 * 初始化命令
	 */
	public class StartupCommand extends SimpleCommand implements ICommand
    {
		/**
		 * 一些操作
		 */
        override public function execute( note:INotification ) : void    
        {
			//
			var stage : Stage = note.getBody() as Stage ;
			facade.registerProxy(new LevelDataProxy()) ;
			facade.registerProxy(new RoleDataProxy()) ;
			facade.registerProxy(new ScoreDataProxy()) ;
			//
			//note
			facade.registerMediator(new StageMediator(stage));
			//facade.removeMediator(StageMediator.NAME);
			var levelData : LevelDataProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			sendNotification(ApplicationFacade.DEPLOY_UI, levelData.level);
		}
	}
}