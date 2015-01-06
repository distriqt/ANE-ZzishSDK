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
 * @file   		SaveFunction.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		02/01/2015
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish.functions.action;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.zzish.ZzishContext;
import com.distriqt.extension.zzish.util.FREUtils;
import com.zzish.platform.sdk.ZZAction;
import com.zzish.platform.sdk.ZZCallback;

public class SaveFunction implements FREFunction
{
	public static String TAG = SaveFunction.class.getSimpleName();

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREUtils.log( TAG, "call" );
		FREObject result = null;
		try
		{
			String actionId = args[0].getProperty( "id" ).getAsString();
			int attempts  	= args[0].getProperty( "attempts" ).getAsInt();
			boolean correct = args[0].getProperty( "correct" ).getAsBool();
			double duration	= args[0].getProperty( "duration" ).getAsDouble();
			String response	= args[0].getProperty( "response" ).getAsString();
			double score	= args[0].getProperty( "score" ).getAsDouble();
			
			ZZAction action = ((ZzishContext)context).controller().getAction( actionId );
			if (action != null)
			{
				action.setAttempts( attempts );
				action.setCorrect( correct );
				action.setDuration( (long)duration );
				action.setResponse( response );
				action.setScore( (float)score );
				
				action.save( new ZZCallback()
				{
					@Override
					public void processResponse( int status, String message )
					{
						FREUtils.log( TAG, String.format( "processResponse( %d, %s )", status, message ));
					}
				});
			}
			else
			{
				FREUtils.log( TAG, "ERROR::Could not find action" );
			}
		}
		catch (Exception e)
		{
			FREUtils.handleException(context, e);
		}
		return result;
	}

}
