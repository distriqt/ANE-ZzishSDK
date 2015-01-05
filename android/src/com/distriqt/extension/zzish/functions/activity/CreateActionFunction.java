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
 * @file   		CreateActionFunction.java
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
import com.distriqt.extension.zzish.ZzishController;
import com.distriqt.extension.zzish.ZzishUtils;
import com.distriqt.extension.zzish.util.FREUtils;
import com.zzish.platform.sdk.ZZAction;
import com.zzish.platform.sdk.ZZActivity;

public class CreateActionFunction implements FREFunction
{
	public static String TAG = CreateActionFunction.class.getSimpleName();

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREUtils.log( TAG, "call" );
		FREObject result = null;
		try
		{
			ZzishController controller = ((ZzishContext)context).controller();
			
			String activityId = args[0].getProperty( "id" ).getAsString();
			String actionName = args[1].getAsString();
			
			ZZActivity activity = controller.getActivity( activityId );
			if (activity != null)
			{
				ZZAction action = activity.createAction( actionName );
				
				String actionId = controller.storeAction( action );
				
				result = ZzishUtils.freObjectFromZzishAction( action, actionId );
			}
		}
		catch (Exception e)
		{
			FREUtils.handleException(context, e);
		}
		return result;
	}

}
