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
 * @file   		Zzish.as
 * @brief  		Zzish Native Extension
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish
{
	import flash.events.EventDispatcher;
	
	
	
	/**	
	 * <p>This class represents the zzish extension.</p>
	 * 
	 * @author	Michael Archbold
	 */
	public final class Zzish extends EventDispatcher
	{
		//
		//	ID and Version numbers
		public static const EXT_CONTEXT_ID			: String = "com.distriqt.Zzish";
		private static const EXT_ID_NUMBER			: int = -1;
		
		public static const VERSION					: String = "1";
		public static const VERSION_DEFAULT			: String = "0";
		public static const IMPLEMENTATION_DEFAULT	: String = "unknown";
		
		
		//
		//	Error Messages
		private static const ERROR_CREATION			: String = "The native extension context could not be created";
		private static const ERROR_SINGLETON		: String = "The extension has already been created. Use ExtensionClass.service to access the functionality of the class";
		
		
		
		public function Zzish()
		{
			if (_shouldCreateInstance)
			{
				_extensionId = EXT_CONTEXT_ID;
				_extensionIdNumber = EXT_ID_NUMBER;
			}
			else
			{
				throw new Error( ERROR_SINGLETON );
			}
		}
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		protected var _extensionId			: String = "";
		protected var _extensionIdNumber	: int = -1;
		
		//
		// Singleton variables
		private static var _instance				: Zzish;
		private static var _shouldCreateInstance	: Boolean = false;
		
		
		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//
		
		public static function get service():Zzish
		{
			createInstance();
			return _instance;
		}
		
		
		private static function createInstance():void
		{
			if(_instance == null)
			{
				_shouldCreateInstance = true; 
				_instance = new Zzish();
				_shouldCreateInstance = false;
			}
		}
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public static function init( developerKey:String ):void
		{
			createInstance();
		}
		
		
		public function dispose():void
		{
			_instance = null;
		}
		
		
		public static function get isSupported():Boolean
		{
			return false;
		}
		
		
		public function get version():String
		{
			var nativeVersion:String  = VERSION_DEFAULT;
			var implementation:String = "default";
			return VERSION+"."+implementation+"."+nativeVersion;
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
	}
}
