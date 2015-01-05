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
 * @file   		ZzishContext.java
 * @brief  		Main Context for an ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.zzish;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.distriqt.extension.zzish.functions.CreateUserFunction;
import com.distriqt.extension.zzish.functions.ImplementationFunction;
import com.distriqt.extension.zzish.functions.IsSupportedFunction;
import com.distriqt.extension.zzish.functions.StartWithApplicationIdFunction;
import com.distriqt.extension.zzish.functions.VersionFunction;
import com.distriqt.extension.zzish.functions.action.SaveFunction;
import com.distriqt.extension.zzish.functions.activity.CancelFunction;
import com.distriqt.extension.zzish.functions.activity.CreateActionFunction;
import com.distriqt.extension.zzish.functions.activity.StartFunction;
import com.distriqt.extension.zzish.functions.activity.StopFunction;
import com.distriqt.extension.zzish.functions.user.CreateActivityFunction;
import com.distriqt.extension.zzish.functions.user.SetNameFunction;

public class ZzishContext extends FREContext 
{
	public static String VERSION = "1.0";
	public static String IMPLEMENTATION = "Android";
	
	public boolean v = false;
	
	private ZzishController _controller = null;
	
	@Override
	public void dispose() 
	{
	}

	
	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		
		functionMap.put( "isSupported", 			new IsSupportedFunction() );
		functionMap.put( "version",   				new VersionFunction() );
		functionMap.put( "implementation", 			new ImplementationFunction() );
		
		functionMap.put( "startWithApplicationId", 	new StartWithApplicationIdFunction() );
		functionMap.put( "createUser", 				new CreateUserFunction() );
		
		functionMap.put( "user_createActivity", 	new CreateActivityFunction() );
		functionMap.put( "user_setName", 			new SetNameFunction() );
		
		functionMap.put( "activity_start", 			new StartFunction() );
		functionMap.put( "activity_stop", 			new StopFunction() );
		functionMap.put( "activity_cancel", 		new CancelFunction() );
		functionMap.put( "activity_createAction", 	new CreateActionFunction() );
		
		functionMap.put( "action_save", 			new SaveFunction() );
		
		return functionMap;
	}
	
	
	public ZzishController controller()
	{
		if (_controller == null)
		{
			_controller = new ZzishController( this );
		}
		return _controller;
	}
	
}
