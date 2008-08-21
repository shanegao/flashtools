package fc.puremvc {
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import fc.puremvc.controller.StartupCommand;		

	/**
	 * @author GaoXian
	 */
	public class ApplicationFacade extends Facade implements IFacade 
	{
		public static const STARTUP : String = "startup";
		/**
		 * 单例访问点
		 */
		public static function getInstance():ApplicationFacade
		{
			if ( instance == null ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
	
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController() : void 
        {
            super.initializeController(); 
            registerCommand(ApplicationFacade.STARTUP, StartupCommand);
		}
        
        /**
         * enter point
         */
         public function startup(main:  Main) : void
         {
         	sendNotification(ApplicationFacade.STARTUP , main) ;
		}
	}
}
