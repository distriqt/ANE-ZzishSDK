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
 * @file   		StartWithApplicationIdFunction.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		02/01/2015
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.zzish.ZzishContext;
import com.distriqt.extension.zzish.util.FREUtils;

public class StartWithApplicationIdFunction implements FREFunction
{
	public static String TAG = StartWithApplicationIdFunction.class.getSimpleName();

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREUtils.log( TAG, "call" );
		FREObject result = null;
		try
		{
			String appId = args[0].getAsString();
			((ZzishContext)context).controller().startWithAppllicationIdFunction( appId );
		}
		catch (Exception e)
		{
			FREUtils.handleException(context, e);
		}
		return result;
	}

}
