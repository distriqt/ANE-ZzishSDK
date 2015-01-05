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
 * @file   		ZzishAction.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Dec 31, 2014
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish
{
	/**
	 * @author 	"Michael Archbold (ma&#64;distriqt.com)"
	 */
	public interface ZzishAction
	{
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		/**
		 * The activity that created the action 
		 */		
		function get activity():ZzishActivity;

		
		/**
		 * The number of attempts the user had
		 */
		function get attempts():int;
		function set attempts(value:int):void;
		

		/**
		 * Whether this action was correct
		 */
		function get correct():Boolean;
		function set correct(value:Boolean):void;
		
		
		/**
		 * The duration it took for the user to complete the action. 
		 * Measured in milliseconds. 
		 */		
		function get duration():Number;
		function set duration(value:Number):void;
		
		
		/**
		 * The name of the action (e.g question)
		 */		
		function get name():String;
		
		
		/**
		 * The response for the action
		 */		
		function get response():String;
		function set response(value:String):void;
		
		
		/**
		 * A score assigned to this action, this will be 
		 * incorporated into the total score for the activity
		 */		
		function get score():Number;
		function set score(value:Number):void;
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 * <p>
		 * Save the activity
		 * </p> 
		 */		
		function save():void;
		
		
	}
}