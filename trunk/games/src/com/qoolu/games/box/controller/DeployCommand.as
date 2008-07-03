package com.qoolu.games.box.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;		

	/**
	 * @author Gaoxian
	 * 初始化界面
	 */
	public class DeployCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(note : INotification) : void 
		{
			trace("DeployCommand");
			
		}
	}
}
