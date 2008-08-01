package com.qoolu.games.box.controller {
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.model.BlockyDataProxy;
	import com.qoolu.games.box.model.LevelDataProxy;		

	/**
	 * @author Gaoxian
	 * 升级命令
	 */
	public class CheckUpgradeCommand extends SimpleCommand implements ICommand 
	{
		/**
		 * 一些操作
		 */
		override public function execute(note : INotification) : void 
		{
			var blockyData : BlockyDataProxy = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
			if(blockyData.checkOver())
			{
				var levelData : LevelDataProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy;
				levelData.levelAdd();//加1级
				sendNotification(ApplicationFacade.UPGRADE);
			}
		}
	}
}
