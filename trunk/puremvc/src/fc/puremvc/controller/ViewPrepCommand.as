package fc.puremvc.controller {
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import fc.puremvc.view.ApplicationMediator;	

	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			var main:Main = notification.getBody() as Main;
			facade.registerMediator( new ApplicationMediator(main) );
		}
	}
}