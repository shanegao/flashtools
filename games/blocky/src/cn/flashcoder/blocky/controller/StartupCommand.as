package cn.flashcoder.blocky.controller
{
	import cn.flashcoder.blocky.model.BlockyDataProxy;
	import cn.flashcoder.blocky.model.LevelDataProxy;
	import cn.flashcoder.blocky.model.ScoreDataProxy;
	import cn.flashcoder.blocky.view.ApplicationMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	

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
			var main : BoxMain = note.getBody() as BoxMain ;
			facade.registerProxy(new LevelDataProxy()) ;
			facade.registerProxy(new BlockyDataProxy()) ;
			facade.registerProxy(new ScoreDataProxy()) ;
			//note
			facade.registerMediator(new ApplicationMediator(main));
			//facade.removeMediator(ApplicationMediator.NAME);
			//var levelData : LevelDataProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy ;
			//sendNotification(ApplicationFacade.DEPLOY_UI, levelData.level);
		}
	}
}