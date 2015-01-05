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
 * @file   		ZzishIsSupportedFunction.java
 * @brief  		Is Supported function implementation for this ANE
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.zzish.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.distriqt.extension.zzish.ZzishController;
import com.distriqt.extension.zzish.util.FREUtils;

public class IsSupportedFunction implements FREFunction 
{
	public static String TAG = IsSupportedFunction.class.getSimpleName();

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREObject result = null;
		try
		{
			result = FREObject.newObject( ZzishController.isSupported() );
		}
		catch (FREWrongThreadException e) 
		{
			FREUtils.handleException( context, e );
		}
		return result;
	}

}
