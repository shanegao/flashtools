/*
 PureMVC AS3 / Flash Demo - HelloFlash
 By Cliff Hall <clifford.hall@puremvc.org>
 Copyright(c) 2007-08, Some rights reserved.
 */
package com.qoolu.games.box.controller {
	import flash.display.Stage;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import com.qoolu.games.box.ApplicationFacade;
	import com.qoolu.games.box.model.SpriteDataProxy;	

	public class StartupCommand extends SimpleCommand implements ICommand
    {
        /**
         * Register the Proxies and Mediators.
         * 
         * Get the View Components for the Mediators from the app,
         * which passed a reference to itself on the notification.
         */
        override public function execute( note:INotification ) : void    
        {
			facade.registerProxy(new SpriteDataProxy());
	    	var stage:Stage = note.getBody() as Stage;
            //facade.registerMediator( new StageMediator( stage ) );
			sendNotification( ApplicationFacade.STAGE_ADD_SPRITE );
        }
    }
}