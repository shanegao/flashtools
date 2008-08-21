package fc.carousel.view 
{
	import org.puremvc.as3.interfaces.INotification;	
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	
	/**
	 * @author GaoXian
	 * 
	 */
	public class ApplicationMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator( viewComponent : Object ) 
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests() : Array 
		{
			return null;
		}
		
		override public function handleNotification(notification : INotification) : void 
		{
			
		}
		
	}
}
