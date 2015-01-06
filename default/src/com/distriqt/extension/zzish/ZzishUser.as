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
 * @file   		ZzishUser.as
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
	public interface ZzishUser
	{
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		
		/**
		 * <p>
		 * The name of the user
		 * </p>
		 */		
		function get name():String;
		function set name(value:String):void;

		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 * <p>
		 * Create an activity for this user
		 * </p>
		 * 
		 * @param activityName	The name of the activity
		 * 
		 * @return 
		 * 
		 */		
		function createActivity( activityName:String ):ZzishActivity;
		
		
	}
}