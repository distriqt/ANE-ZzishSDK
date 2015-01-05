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
	import flash.external.ExtensionContext;
	
	/**	
	 * @author	"Michael Archbold (ma&#64;distriqt.com)"
	 */
	internal class ZzishUserImpl implements ZzishUser
	{
		
		/**
		 *  Constructor
		 */
		public function ZzishUserImpl( extContext:ExtensionContext, details:Object )
		{
			_extContext = extContext;	
			if (details)
			{
				if (details.hasOwnProperty("userId")) 	this._userId 	= details.userId;
				if (details.hasOwnProperty("name")) 	this._name 		= details.name;
			}
		}
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _extContext : ExtensionContext;
		
		
		private var _userId	: String;
		/**
		 * @inheritDoc
		 */		
		public function get userId():String { return _userId; }
		public function set userId(value:String):void { _userId = value; }
		
		
		private var _name	: String;
		/**
		 * @inheritDoc
		 */		
		public function get name():String { return _name; }
		public function set name(value:String):void { if (_extContext.call( "user_setName", this, value )) _name = value; }

		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//

		/**
		 * @inheritDoc
		 */		
		public function createActivity( activityName:String ):ZzishActivity
		{
			var activity:ZzishActivity = new ZzishActivityImpl( _extContext, _extContext.call( "user_createActivity", this, activityName ) as Object );
			return activity;
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}