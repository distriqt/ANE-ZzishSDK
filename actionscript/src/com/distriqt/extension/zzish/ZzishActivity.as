/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @file   		ZzishActivity.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Dec 31, 2014
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish
{
	/**	
	 * <p>
	 * A Zzish activity is an event with measured time (it starts and stops). 
	 * Examples of Zzish activities include a quiz, playing a level or watching 
	 * a video. Provide a name that will help easily identify the activity to 
	 * the end user
	 * </p>
	 * <p>
	 * The activity will only be uploaded once you call the .start method
	 * </p>
	 * <p>
	 * In order for data to appear on the teacher dashboard, you will need 
	 * to set the Zzish Class Code for the activity. This must be done everytime 
	 * you create the activity. This is to ensure you have full control. 
	 * The Zzish Class Code is found by creating a class on the Learning Hub. 
	 * This is a unique code assigned to each class created. A teacher simply 
	 * needs to log in to the Learning Hub to view both live and historical data 
	 * of progress within your app.
	 * </p>
	 * 
	 * @author	"Michael Archbold (ma&#64;distriqt.com)"
	 */
	public interface ZzishActivity
	{
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		
		/**
		 * The name of the user
		 */		
		function get name():String;
		function set name(value:String):void;
		
		
		/**
		 * The Zzish Class Code for the activity
		 */		
		function get groupCode():String;
		function set groupCode(value:String):void;
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 * Start the activity 
		 */		
		function start():void;
		
		
		/**
		 * Stop the activity 
		 */		
		function stop():void;
		
		
		/**
		 * Cancel the activity 
		 */		
		function cancel():void;
		
		
		/**
		 * Create an action for this activity
		 *  
		 * @param name	The name of the action
		 * @return 
		 */		
		function createAction( name:String ):ZzishAction;
		
		
	}
}