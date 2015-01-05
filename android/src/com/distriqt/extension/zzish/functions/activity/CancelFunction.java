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
 * @file   		CancelFunction.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		02/01/2015
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish.functions.activity;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.zzish.ZzishContext;
import com.distriqt.extension.zzish.util.FREUtils;
import com.zzish.platform.sdk.ZZActivity;
import com.zzish.platform.sdk.ZZCallback;

public class CancelFunction implements FREFunction
{
	public static String TAG = CancelFunction.class.getSimpleName();

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREUtils.log( TAG, "call" );
		FREObject result = null;
		try
		{
			String activityId = args[0].getProperty( "id" ).getAsString();
			
			ZZActivity activity = ((ZzishContext)context).controller().getActivity( activityId );
			if (activity != null)
			{
				activity.cancel( new ZZCallback()
				{
					@Override
					public void processResponse( int status, String message )
					{
						FREUtils.log( TAG, String.format( "processResponse( %d, %s )", status, message ));
					}
				});
			}
		}
		catch (Exception e)
		{
			FREUtils.handleException(context, e);
		}
		return result;
	}

}
