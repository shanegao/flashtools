package fc.carousel.controller {
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import fc.carousel.model.DataProxy;	

	public class ModelPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerProxy( new DataProxy() );
		}
	}
}