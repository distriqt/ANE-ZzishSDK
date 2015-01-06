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
 * @file   		SetNameFunction.java
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
import com.distriqt.extension.zzish.util.FREUtils;
import com.zzish.platform.sdk.ZZCallback;
import com.zzish.platform.sdk.ZZUser;

public class SetNameFunction implements FREFunction
{
	public static String TAG = SetNameFunction.class.getSimpleName();

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREUtils.log( TAG, "call" );
		FREObject result = null;
		try
		{
			String userId 	= args[0].getProperty( "userId" ).getAsString();
			String name 	= args[1].getAsString();
			
			ZZUser user = ((ZzishContext)context).controller().createUser( userId );
			user.setName( name );
			user.save( new ZZCallback()
			{
				@Override
				public void processResponse( int arg0, String arg1 )
				{
				}
			});
			
			result = FREObject.newObject( true );
		}
		catch (Exception e)
		{
			FREUtils.handleException(context, e);
		}
		return result;
	}

}
