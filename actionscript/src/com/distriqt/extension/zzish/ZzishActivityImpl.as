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
 * @file   		ZzishActivityImpl.as
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
	internal class ZzishActivityImpl implements ZzishActivity
	{
		
		/**
		 *  Constructor
		 */
		public function ZzishActivityImpl( extContext:ExtensionContext, details:Object )
		{
			_extContext = extContext;
			if (details)
			{
				if (details.hasOwnProperty("id")) 			this._id 		= details.id;
				if (details.hasOwnProperty("name")) 		this._name		= details.name;
				if (details.hasOwnProperty("groupCode")) 	this._groupCode = details.groupCode;
			}
		}
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _extContext : ExtensionContext;
		
		
		private var _id	: String = "";
		/**
		 * Internal id used for native communications to identify this object
		 */		
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		
		
		private var _name	: String = "";
		/**
		 * @inheritDoc
		 */		
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		
		private var _groupCode	: String = "";
		/**
		 * @inheritDoc
		 */		
		public function get groupCode():String { return _groupCode; }
		public function set groupCode(value:String):void { _groupCode = value; }

		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		
		/**
		 * @inheritDoc
		 */		
		public function start():void
		{
			_extContext.call( "activity_start", this );
		}
		
		
		/**
		 * @inheritDoc
		 */		
		public function stop():void
		{
			_extContext.call( "activity_stop", this );
		}
		
		
		/**
		 * @inheritDoc
		 */		
		public function cancel():void
		{
			_extContext.call( "activity_cancel", this );
		}
		
		
		/**
		 * @inheritDoc
		 */		
		public function createAction( name:String ):ZzishAction
		{
			var action:ZzishAction = new ZzishActionImpl( _extContext, this, _extContext.call( "activity_createAction", this, name ) as Object );
			return action;
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}