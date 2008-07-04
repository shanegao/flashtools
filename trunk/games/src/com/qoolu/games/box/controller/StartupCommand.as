package com.qoolu.games.box.controller {
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.model.LevelDataProxy;
	import com.qoolu.games.box.model.RoleDataProxy;
	import com.qoolu.games.box.model.ScoreDataProxy;
	import com.qoolu.games.box.view.ApplicationMediator;		

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
			var main : BoxMain = note.getBody() as BoxMain ;
			facade.registerProxy(new LevelDataProxy()) ;
			facade.registerProxy(new RoleDataProxy()) ;
			facade.registerProxy(new ScoreDataProxy()) ;
			//
			//note
			facade.registerMediator(new ApplicationMediator(main));
			//facade.removeMediator(StageMediator.NAME);
			var levelData : LevelDataProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			sendNotification(ApplicationFacade.DEPLOY_UI, levelData.level);
		}
	}
}