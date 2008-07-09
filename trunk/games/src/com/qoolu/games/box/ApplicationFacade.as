package com.qoolu.games.box {
	import com.qoolu.games.box.controller.AddScoreCommand;	
	import com.qoolu.games.box.controller.UserSelectCommand;	
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import com.qoolu.games.box.controller.GameOverCommand;
	import com.qoolu.games.box.controller.StartupCommand;
	import com.qoolu.games.box.controller.UpgradeCommand;		

	public class ApplicationFacade extends Facade implements IFacade
    {
        public static const STARTUP : String  		= "startup";
        public static const UPGRADE : String 	= "upgrade";
		public static const START_GAME : String		= "start_game";
		public static const RESTART_GAME : String = "restart_game";
		public static const GAME_OVER : String = "gameOVer"; 
		public static const GAME_GUIDE : String = "gameGuide";
		public static const USER_SELECT : String = "userSelect";
		public static const ADD_SCORE : String = "addScore";
		
		public static const RE_DRAW : String = "re_drew";
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
            registerCommand(STARTUP, StartupCommand );
            registerCommand(UPGRADE, UpgradeCommand);
            registerCommand(GAME_OVER, GameOverCommand); 
            registerCommand(USER_SELECT, UserSelectCommand);
            registerCommand(ADD_SCORE, AddScoreCommand);
		}
        
        public function startup( main:Object ):void
        {
        	sendNotification( STARTUP, main );
        }
        
    }
}