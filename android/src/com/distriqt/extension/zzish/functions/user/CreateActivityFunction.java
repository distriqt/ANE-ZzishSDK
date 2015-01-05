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
 * @file   		CreateActivityFunction.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		02/01/2015
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish.functions.user;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.zzish.ZzishContext;
import com.distriqt.extension.zzish.ZzishController;
import com.distriqt.extension.zzish.ZzishUtils;
import com.distriqt.extension.zzish.util.FREUtils;
import com.zzish.platform.sdk.ZZActivity;
import com.zzish.platform.sdk.ZZUser;

public class CreateActivityFunction implements FREFunction
{
	public static String TAG = CreateActivityFunction.class.getSimpleName();

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREUtils.log( TAG, "call" );
		FREObject result = null;
		try
		{
			ZzishController controller = ((ZzishContext)context).controller();
			
			String userId 		= args[0].getProperty( "userId" ).getAsString();
			String activityName	= args[1].getAsString();
			
			ZZUser user = controller.createUser( userId );

			ZZActivity activity = user.createActivity( activityName );
			
			String activityId = controller.storeActivity( activity );
			
			result = ZzishUtils.freObjectFromZzishActivity( activity, activityId );
		}
		catch (Exception e)
		{
			FREUtils.handleException(context, e);
		}
		return result;
	}

}
