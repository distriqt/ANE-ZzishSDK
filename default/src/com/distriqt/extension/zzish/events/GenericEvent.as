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
 * @file   		GenericEvent.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Sep 12, 2013
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish.events
{
	import flash.events.Event;
	
	
	/**	
	 * @author	"Michael Archbold (ma&#64;distriqt.com)"
	 */
	public class GenericEvent extends Event
	{
		
		/**
		 * <p>
		 * This is a generic extension error. This should only be dispatched
		 * in very unusual situations and is more used during debugging than
		 * in live application situations.
		 * </p> 
		 */		
		public static const ERROR	: String = "extension:error";
		
		
		/**
		 *  Constructor
		 */
		public function GenericEvent(type:String, message:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.message = message;
		}
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		public var message	: String = "";
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}
