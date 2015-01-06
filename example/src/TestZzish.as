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
 * This is a test application for the distriqt extension
 * 
 * @author Michael Archbold & Shane Korin
 * 	
 */
package
{
	import com.distriqt.extension.zzish.Zzish;
	import com.distriqt.extension.zzish.ZzishAction;
	import com.distriqt.extension.zzish.ZzishActivity;
	import com.distriqt.extension.zzish.ZzishUser;
	import com.distriqt.extension.zzish.events.ZzishEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**	
	 * Sample application for using the Zzish Native Extension
	 * 
	 * @author	Michael Archbold
	 */
	public class TestZzish extends Sprite
	{
		public static const ZZISH_APPLICATION_ID	: String = "e2593e40-56b7-4d32-ae0d-68586413d684";
		public static const ZZISH_CLASS_CODE		: String = "b6t";
		
		
		/**
		 * Class constructor 
		 */	
		public function TestZzish()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			init();
		}
		
		
		//
		//	VARIABLES
		//
		
		private var _text		: TextField;
		
		
		//
		//	INITIALISATION
		//	
		
		private function init( ):void
		{
			// 
			//	Create a text field to display some output
			var tf:TextFormat = new TextFormat( null, 24 );
			_text = new TextField();
			_text.defaultTextFormat = tf;
			addChild( _text );
			
			//
			//	Setting up the Zzish service listeners and setting the application id
			try
			{
				message( "Zzish Supported: " + Zzish.isSupported );
				message( "Zzish Version:   " + Zzish.service.version );
				
				Zzish.service.addEventListener( ZzishEvent.SETUP_SUCCESS, zzish_setupSuccessHandler );
				Zzish.service.addEventListener( ZzishEvent.SETUP_FAILED,  zzish_setupFailedHandler );
				
				Zzish.service.startWithApplicationId( ZZISH_APPLICATION_ID );
				
			}
			catch (e:Error)
			{
				message( "ERROR::"+e.message );
			}

			stage.addEventListener( Event.RESIZE, stage_resizeHandler, false, 0, true );
			stage.addEventListener( MouseEvent.CLICK, mouseClickHandler, false, 0, true );
		}
		
		
		//
		//	FUNCTIONALITY
		//
		
		private function message( str:String ):void
		{
			trace( str );
			_text.appendText(str+"\n");
		}
		
		
		//
		//	EVENT HANDLERS
		//
		
		private function stage_resizeHandler( event:Event ):void
		{
			_text.width  = stage.stageWidth;
			_text.height = stage.stageHeight;
		}
		
		
		private function mouseClickHandler( event:MouseEvent ):void
		{
			message( "Perform simple test" );
			
			//
			//	Create a user
			var user:ZzishUser = Zzish.service.createUser( "0333AF2_"+Zzish.service.version );
			user.name = "Test User (" + Zzish.service.version+")";

			
			//
			//	Create an activity
			var activity:ZzishActivity = user.createActivity( "Starting ANE Development" );
			activity.groupCode = ZZISH_CLASS_CODE;
			activity.start();

			
			//
			//	Create an action
			var action:ZzishAction = activity.createAction( "Question 1" );
			action.response = "a great response";
			action.correct = (Math.random() > 0.5);
			action.score = Math.floor(Math.random() * 100);
			action.save();
			
		}
		
		
		
		//
		//	EXTENSION HANDLERS
		//
		
		private function zzish_setupSuccessHandler( event:ZzishEvent ):void
		{
			message( "zzish_setupSuccessHandler::"+event.status + "::"+event.message );
		}
		
		private function zzish_setupFailedHandler( event:ZzishEvent ):void
		{
			message( "zzish_setupFailedHandler::"+event.status + "::"+event.message );
		}
		
	}
}

