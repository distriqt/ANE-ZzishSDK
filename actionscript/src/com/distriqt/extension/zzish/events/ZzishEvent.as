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
 * @file   		ZzishEvent.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Dec 31, 2014
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish.events
{
	import flash.events.Event;
	
	
	/**	
	 * @author	"Michael Archbold (ma&#64;distriqt.com)"
	 */
	public class ZzishEvent extends Event
	{
		/**
		 * <p>
		 * Dispatched after a call to <code>startWithApplicationId</code> is successful.
		 * </p>
		 * 
		 * @see com.distriqt.extension.zzish.Zzish#startWithApplicationId() 
		 */		
		public static const SETUP_SUCCESS	: String = "zzish:setup:success";
		
		
		/**
		 * <p>
		 * Dispatched after a call to <code>startWithApplicationId</code> fails 
		 * or there is an error.
		 * </p>
		 * 
		 * <p>
		 * <code>message</code> will contain the reason for the failure.
		 * </p>
		 * 
		 * @see com.distriqt.extension.zzish.Zzish#startWithApplicationId() 
		 */		
		public static const SETUP_FAILED	: String = "zzish:setup:failed";
		
		
		
		/**
		 *  Constructor
		 */
		public function ZzishEvent(type:String, message:String, status:int=0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.status 	= status;
			this.message 	= message;
		}
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		public var status 	: int;
		public var message	: String;
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		override public function clone():Event
		{
			return new ZzishEvent( type, message, status, bubbles, cancelable );
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}