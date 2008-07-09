package com.qoolu.games.box.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import com.qoolu.games.box.model.LevelDataProxy;		

	/**
	 * @author Gaoxian
	 * 升级命令
	 */
	public class UpgradeCommand extends SimpleCommand implements ICommand 
	{
		/**
		 * 一些操作
		 */
		override public function execute(note : INotification) : void 
		{
			var levelData : LevelDataProxy = facade.retrieveProxy(LevelDataProxy.NAME) as LevelDataProxy;
			levelData.levelAdd();//加1级
		}
	}
}
