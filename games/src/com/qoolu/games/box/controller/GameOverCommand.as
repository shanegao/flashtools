package com.qoolu.games.box.controller {
	import org.puremvc.as3.interfaces.INotification;	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.ICommand;
	
	/**
	 * @author Gaoxian
	 * 游戏结束命令
	 */
	public class GameOverCommand extends SimpleCommand implements ICommand 
	{
		/**
		 * 一些操作
		 */
		override public function execute(note : INotification) : void 
		{
			
		}
	}
}
