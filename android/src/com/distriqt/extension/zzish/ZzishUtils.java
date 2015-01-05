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
 * @file   		ZzishUtils.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		05/01/2015
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish;

import com.adobe.fre.FREObject;
import com.distriqt.extension.zzish.util.FREUtils;
import com.zzish.platform.sdk.ZZAction;
import com.zzish.platform.sdk.ZZActivity;
import com.zzish.platform.sdk.ZZUser;

public class ZzishUtils
{
	
	public static FREObject freObjectFromZZUser( ZZUser user )
	{
		FREObject result = null;
		try
		{
			result = FREObject.newObject( "Object", null );
		
			result.setProperty( "name", FREObject.newObject( user.getName() == null ? "" : user.getName() ));
		}
		catch (Exception e)
		{
			FREUtils.handleException( null, e ); 
		}
		return result;
	}
	
	
	public static FREObject freObjectFromZzishActivity( ZZActivity activity, String activityId )
	{
		FREObject result = null;
		try
		{
			result = FREObject.newObject( "Object", null );
		
			result.setProperty( "id", FREObject.newObject( activityId ));
			result.setProperty( "name",	FREObject.newObject( activity.getName() ));
			result.setProperty( "groupCode", FREObject.newObject( activity.getGroupCode() ));
		}
		catch (Exception e)
		{
			FREUtils.handleException( null, e ); 
		}
		return result;
	}

	
	public static FREObject freObjectFromZzishAction( ZZAction action, String actionId )
	{
		FREObject result = null;
		try
		{
			result = FREObject.newObject( "Object", null );
		
			result.setProperty( "id", FREObject.newObject( actionId ));
			result.setProperty( "name",	FREObject.newObject( action.getName() ));
		}
		catch (Exception e)
		{
			FREUtils.handleException( null, e ); 
		}
		return result;
	}
	
}
