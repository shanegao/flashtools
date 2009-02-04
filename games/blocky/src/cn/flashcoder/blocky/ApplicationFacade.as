package cn.flashcoder.blocky 
{
	
	
	import cn.flashcoder.blocky.controller.AddScoreCommand;
	import cn.flashcoder.blocky.controller.CheckUpgradeCommand;
	import cn.flashcoder.blocky.controller.GameOverCommand;
	import cn.flashcoder.blocky.controller.StartupCommand;
	import cn.flashcoder.blocky.controller.UserSelectCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;		

	public class ApplicationFacade extends Facade implements IFacade
    {
        public static const STARTUP : String  		= "startup";
        public static const UPGRADE : String 	= "upgrade";
        public static const CHECK_UPGRADE : String = "checkupgrade";
		public static const START_GAME : String		= "start_game";
		public static const RESTART_GAME : String = "restart_game";
		public static const GAME_OVER : String = "gameOVer"; 
		public static const GAME_GUIDE : String = "gameGuide";
		public static const USER_SELECT : String = "userSelect";
		public static const ADD_SCORE : String = "addScore";
		public static const REMOVE_BLANK : String = "remove blank";
		public static const REMOVE_FAIL : String = "remove fail" ; 
		public static const RE_DRAW : String = "re_drew";
		public static const TIMER_REPEAT :int = 180 ;
         
        public function ApplicationFacade( key:String )
        {
            super(key);    
        }

        /**
         * ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : ApplicationFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new ApplicationFacade( key );
            return instanceMap[ key ] as ApplicationFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController() : void 
        {
            super.initializeController(); 
                     
            registerCommand(STARTUP, StartupCommand );
            registerCommand(CHECK_UPGRADE, CheckUpgradeCommand);
            registerCommand(GAME_OVER, GameOverCommand); 
            registerCommand(USER_SELECT, UserSelectCommand);
            registerCommand(ADD_SCORE, AddScoreCommand);
            trace("oooooooooooooooooooooooooooooooooooooo");  
		}
        
        public function startup( main:Object ):void
        {
        	sendNotification( STARTUP, main );
        }
        
    }
}