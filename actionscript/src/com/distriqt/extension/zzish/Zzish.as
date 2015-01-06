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
	import com.distriqt.extension.zzish.events.GenericEvent;
	import com.distriqt.extension.zzish.events.ZzishEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	
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
		
		public static const VERSION					: String = "1";
		public static const VERSION_DEFAULT			: String = "0";
		public static const IMPLEMENTATION_DEFAULT	: String = "unknown";
		
		//
		//	Error Messages
		private static const ERROR_CREATION			: String = "The native extension context could not be created";
		private static const ERROR_SINGLETON		: String = "The singleton has already been created. Use Zzish.service to access the functionality";
		
		
		/**
		 * Constructor
		 * 
		 * You should not call this directly, but instead use the singleton access
		 */
		public function Zzish()
		{
			if (_shouldCreateInstance)
			{
				try
				{
					_extensionId = EXT_CONTEXT_ID;
					_extContext = ExtensionContext.createExtensionContext( EXT_CONTEXT_ID, null );
					_extContext.addEventListener( StatusEvent.STATUS, extension_statusHandler, false, 0, true );
				}
				catch (e:Error)
				{
					throw new Error( ERROR_CREATION );
				}
			}
			else
			{
				throw new Error( ERROR_SINGLETON );
			}
		}
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private static var _extContext	: ExtensionContext = null;
		
		private var _extensionId		: String = "";
		
		//
		// Singleton variables
		private static var _instance				: Zzish;
		private static var _shouldCreateInstance	: Boolean = false;
		
		
		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//
		
		/**
		 * The singleton instance of the Zzish class.
		 * @throws Error If there was a problem creating or accessing the extension, or if the developer key is invalid
		 */
		public static function get service():Zzish
		{
			createInstance();
			return _instance;
		}
		
		
		/**
		 * @private
		 * Creates the actual singleton instance 
		 */
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
		
		/**
		 * <p>
		 * Disposes the extension and releases any allocated resources. Once this function 
		 * has been called, a call to <code>init</code> is neccesary again before any of the 
		 * extensions functionality will work.
		 * </p>
		 */		
		public function dispose():void
		{
			if (_extContext)
			{
				_extContext.removeEventListener( StatusEvent.STATUS, extension_statusHandler );
				_extContext.dispose();
				_extContext = null;
			}
			_instance = null;
		}
		
		
		/**
		 * Whether the current device supports the extensions functionality
		 */
		public static function get isSupported():Boolean
		{
			createInstance();
			return _extContext.call( "isSupported" );
		}
		
		
		/**
		 * <p>
		 * The version string of the native extension. This will be of the format:
		 * </p>
		 * <pre>
		 * [main version].[base version].[implementation].[native version]
		 * </pre>
		 */
		public function get version():String
		{
			var nativeVersion:String  = VERSION_DEFAULT;
			var implementation:String = IMPLEMENTATION_DEFAULT;
			try
			{
				nativeVersion  = _extContext.call( "version" ) as String;
				implementation = _extContext.call( "implementation" ) as String;
			}
			catch (e:Error)
			{
			}
			return VERSION+"."+implementation+"."+nativeVersion;
		}
		
		
		//
		//
		//	ZZISH SDK FUNCTIONALITY
		//
		//
		
		/**
		 * <p>
		 * This function sets up the Zzish SDK using the APP_ID you received 
		 * when you registered your app with Zzish (see developer console):
		 * </p>
		 * 
		 * <p>
		 * <a href="http://www.zzish.co.uk/developer/apps">developer console</a>
		 * </p>
		 * 
		 * <p>
		 * The setup will be performed asynchronously, so it is important to ensure that anything which depends on it waits until after the callback.
		 * You may want to indicate to the user that something is happening e.g. via a ProgressBar in indeterminate state; set the visibility to gone when you get the callback.
		 * </p>
		 * 
		 * @param applicationId The APP_ID you received when you registered your app with Zzish
		 * 
		 */		
		public function startWithApplicationId( applicationId:String ):void
		{
			_extContext.call( "startWithApplicationId", applicationId );
		}
		
		
		/**
		 * <p>
		 * Creates a Zzish User
		 * </p>
		 * 
		 * <p>
		 * The Zzish user integrates with any 3rd party login system 
		 * (e.g. Facebook, Google +) or your very own system. It simply 
		 * requires a Unique ID which must be unique across all the users 
		 * of your App. Therefore if you provide a duplicate User ID for
		 * a future event, the events will be logged in for the original User.
		 * </p> 
		 * 
		 * <p>
		 * When you set the name of the user, and the user is created for the 
		 * very first time on our servers, the name will also be saved. Any 
		 * future updates will not be saved.
		 * </p>
		 * 
		 * @param userId Unique ID which must be unique across all the users of your App
		 * 
		 * @return 
		 * 
		 */		
		public function createUser( userId:String ):ZzishUser
		{
			var user:ZzishUser = new ZzishUserImpl( _extContext, _extContext.call( "createUser", userId ) as Object );
			return user;
		}
		
		
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		private function extension_statusHandler( event:StatusEvent ):void
		{
			switch (event.code)
			{
				case "extension:error":
					dispatchEvent( new GenericEvent( GenericEvent.ERROR, event.level ));
					break;
				
				case ZzishEvent.SETUP_SUCCESS:
				case ZzishEvent.SETUP_FAILED:
				{
					dispatchEvent( new ZzishEvent( event.code, event.level ));
					break;
				}
			}
		}
		
		
	}
}
