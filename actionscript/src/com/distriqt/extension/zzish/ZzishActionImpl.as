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
 * @file   		ZzishActionImpl.as
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
	internal class ZzishActionImpl implements ZzishAction
	{
		/**
		 *  Constructor
		 */
		public function ZzishActionImpl( extContext:ExtensionContext, activity:ZzishActivity, details:Object )
		{
			_extContext = extContext;
			_activity   = activity;
			
			if (details)
			{
				if (details.hasOwnProperty("id")) 		_id 		= details.id;
				if (details.hasOwnProperty("attempts")) _attempts 	= details.attempts;
				if (details.hasOwnProperty("correct"))	_correct 	= details.correct;
				if (details.hasOwnProperty("duration")) _duration 	= details.duration;
				if (details.hasOwnProperty("name")) 	_name 		= details.name;
				if (details.hasOwnProperty("response")) _response 	= details.response;
				if (details.hasOwnProperty("score")) 	_score 		= details.score;
			}
		}
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _extContext	: ExtensionContext;
		

		private var _id	: String = "";
		/**
		 * Internal id used for native communications to identify this object
		 */		
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		
		
		private var _activity	: ZzishActivity;
		/**
		 * @inheritDoc
		 */		
		public function get activity():ZzishActivity { return _activity; }
		
		
		private var _attempts	: int = 0;
		/**
		 * @inheritDoc
		 */		
		public function get attempts():int { return _attempts; }
		public function set attempts(value:int):void { _attempts = value; }
		
		
		private var _correct	: Boolean = false;
		/**
		 * @inheritDoc
		 */		
		public function get correct():Boolean { return _correct; }
		public function set correct(value:Boolean):void { _correct = value; }

		
		private var _duration	: Number = 0;
		/**
		 * @inheritDoc
		 */		
		public function get duration():Number { return _duration; }
		public function set duration(value:Number):void { _duration = value; }

		
		private var _name		: String = "";
		/**
		 * @inheritDoc
		 */		
		public function get name():String { return _name; }

		
		private var _response	: String = "";
		/**
		 * @inheritDoc
		 */		
		public function get response():String { return _response; }
		public function set response(value:String):void { _response = value; }

		
		private var _score		: Number = 0;
		/**
		 * @inheritDoc
		 */		
		public function get score():Number { return _score; }
		public function set score(value:Number):void { _score = value; }

		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		
		/**
		 * @inheritDoc
		 */		
		public function save():void
		{
			_extContext.call( "action_save", this );
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}