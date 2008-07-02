package com.qoolu.games.box.controller {
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;	

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
        }
    }
}