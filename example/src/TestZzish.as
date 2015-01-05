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
		
		public static const ZZISH_APPLICATION_ID	: String = "zvzQqQ5KciYq3HDejYOV2onR4mMa";
		
		
		/**
		 * Class constructor 
		 */	
		public function TestZzish()
		{
			super();
			create();
			init();
		}
		
		
		//
		//	VARIABLES
		//
		
		private var _text		: TextField;
		
		
		//
		//	INITIALISATION
		//	
		
		private function create( ):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var tf:TextFormat = new TextFormat();
			tf.size = 24;
			_text = new TextField();
			_text.defaultTextFormat = tf;
			addChild( _text );

			stage.addEventListener( Event.RESIZE, stage_resizeHandler, false, 0, true );
			stage.addEventListener( MouseEvent.CLICK, mouseClickHandler, false, 0, true );
			
		}
		
		
		private function init( ):void
		{
			try
			{
				message( "Zzish Supported: " + Zzish.isSupported );
				message( "Zzish Version:   " + Zzish.service.version );
				
				//
				//	Add tests here
				//
				
				Zzish.service.addEventListener( ZzishEvent.SETUP_SUCCESS, zzish_setupSuccessHandler );
				Zzish.service.addEventListener( ZzishEvent.SETUP_FAILED,  zzish_setupFailedHandler );
				
				Zzish.service.startWithApplicationId( ZZISH_APPLICATION_ID );
				
			}
			catch (e:Error)
			{
				message( "ERROR::"+e.message );
			}
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
			_text.height = stage.stageHeight - 100;
		}
		
		
		private function mouseClickHandler( event:MouseEvent ):void
		{
			//
			//	Do something when user clicks screen?
			//	
			
			var user:ZzishUser = Zzish.service.createUser( "0333AF" );
			user.name = "Test User";
			
			var activity:ZzishActivity = user.createActivity( "Starting ANE Development" );
			activity.groupCode = "DEV101";
			activity.start();
			
			var action:ZzishAction = activity.createAction( "Question 1" );
			action.response = "a great response";
			action.correct = false;
			action.save();
			
		}
		
		
		
		//
		//	EXTENSION HANDLERS
		//
		
		private function zzish_setupSuccessHandler( event:ZzishEvent ):void
		{
			
		}
		
		private function zzish_setupFailedHandler( event:ZzishEvent ):void
		{
			
		}
		
	}
}

