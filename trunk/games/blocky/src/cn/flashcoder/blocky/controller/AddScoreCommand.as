package cn.flashcoder.blocky.controller
{
	import cn.flashcoder.blocky.model.ScoreDataProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;		

	/**
	 * @author Gaoxian
	 * 加分
	 */
	public class AddScoreCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(note : INotification) : void 
		{
			var params : Array = note.getBody() as Array ;
			var score : ScoreDataProxy = facade.retrieveProxy(ScoreDataProxy.NAME) as ScoreDataProxy ;
			score.addScore(params[0], params[1], params[2]);	
			trace("AddScoreCommand  :" + score.totalScore);	
		}
	}
}
