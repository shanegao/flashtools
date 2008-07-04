package com.qoolu.games.box {
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import com.qoolu.games.box.controller.GameOverCommand;
	import com.qoolu.games.box.controller.DeployCommand;
	import com.qoolu.games.box.controller.StartupCommand;
	import com.qoolu.games.box.controller.UpgradeCommand;		

	public class ApplicationFacade extends Facade implements IFacade
    {
        public static const STARTUP : String  		= "startup";
        public static const UPGRADE : String 	= "upgrade";
		public static const DEPLOY_UI : String		= "deploy";
		public static const GAME_OVER : String = "gameOVer"; 

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade 
        {
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController() : void 
        {
            super.initializeController();            
            registerCommand( STARTUP, StartupCommand );
            registerCommand(DEPLOY_UI, DeployCommand) ; 
            registerCommand(UPGRADE, UpgradeCommand);
            registerCommand(GAME_OVER, GameOverCommand); 
		}
        
        public function startup( main:Object ):void
        {
        	sendNotification( STARTUP, main );
        }
        
    }
}