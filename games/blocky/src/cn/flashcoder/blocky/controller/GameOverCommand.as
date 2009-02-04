package cn.flashcoder.blocky.controller 
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;		

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
			//facade.registerMediator()
			trace("Game over @ GameOverCommand " );
			
		}
	}
}
