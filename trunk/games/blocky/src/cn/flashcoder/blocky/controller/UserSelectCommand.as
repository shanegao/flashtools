package com.qoolu.games.box.controller {
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import com.qoolu.games.box.model.BlockyDataProxy;		

	/**
	 * @author Administrator
	 */
	public class UserSelectCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(note : INotification) : void 
		{
			var blockies : Array = note.getBody() as Array ;
			var data : BlockyDataProxy = facade.retrieveProxy(BlockyDataProxy.NAME) as BlockyDataProxy ;
			data.userSelect(blockies[0], blockies[1]) ;
		}
	}
}
