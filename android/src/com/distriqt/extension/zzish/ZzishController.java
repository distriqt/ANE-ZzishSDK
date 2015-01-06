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
 * @file   		ZzishController.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		05/01/2015
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish;

import java.util.ArrayList;

import com.adobe.fre.FREContext;
import com.distriqt.extension.zzish.events.ZzishEvent;
import com.distriqt.extension.zzish.util.FREUtils;
import com.zzish.platform.sdk.ZZAction;
import com.zzish.platform.sdk.ZZActivity;
import com.zzish.platform.sdk.ZZCallback;
import com.zzish.platform.sdk.ZZUser;
import com.zzish.platform.sdk.Zzish;
import com.zzish.platform.sdk.ZzishFactory;
import com.zzish.platform.sdk.ZzishService;

public class ZzishController
{
	public static String TAG = ZzishController.class.getSimpleName();
	
	private FREContext _context = null;
	private ZzishService _zzish = null;
	
	private ArrayList<ZZActivity> 	_activities;
	private ArrayList<ZZAction> 	_actions;
	
	
	public static boolean isSupported()
	{
		return true;
	}
	
	
	public ZzishController( FREContext context )
	{
		_context = context;
		_activities = new ArrayList<ZZActivity>();
		_actions    = new ArrayList<ZZAction>();
	}
	
	
	public void startWithAppllicationIdFunction( String appId )
	{
		_zzish = ZzishFactory.getInstance( 
					_context.getActivity().getApplicationContext(), 
					appId,
					new ZZCallback()
					{
						@Override
						public void processResponse( int status, String message )
						{
							FREUtils.log( TAG, String.format( "processResponse( %d, %s )", status, message ));
							if (status == Zzish.STATUS_OK)
							{
								_context.dispatchStatusEventAsync( ZzishEvent.SETUP_SUCCESS, message == null ? "" : message );
							}
							else
							{
								_context.dispatchStatusEventAsync( ZzishEvent.SETUP_FAILED, message == null ? "" : message );
							}
						}
					});
	}
	
	
	public ZZUser createUser( String userId )
	{
		ZZUser user = _zzish.getUser( userId );
		return user;
	}
	
	
	public String storeActivity( ZZActivity activity )
	{
		String activityId = Integer.toString( _activities.size() );
		_activities.add( activity );
		return activityId;
	}

	
	public ZZActivity getActivity( String activityId )
	{
		int index = Integer.parseInt( activityId );
		if (index >= 0 && index < _activities.size())
			return _activities.get( index );
		return null;
	}
	
	
	public String storeAction( ZZAction action )
	{
		String actionId = Integer.toString( _actions.size() );
		_actions.add( action );
		return actionId;
	}

	
	public ZZAction getAction( String actionId )
	{
		int index = Integer.parseInt( actionId );
		if (index >= 0 && index < _actions.size())
			return _actions.get( index );
		return null;
	}
	
	
}
