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
 * @file   		FREUtils.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Aug 29, 2013
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.zzish.util;

import android.util.Log;
import android.view.View;
import android.view.ViewGroup;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.distriqt.extension.zzish.ZzishExtension;
import com.distriqt.extension.zzish.events.ExtensionEvent;

public class FREUtils
{
	public static Boolean DEBUG_ENABLED = true;
	public static Boolean DEBUG_OUTPUTS_ENABLED = true;
	
	public static void log( String TAG, String message )
	{
		if (DEBUG_OUTPUTS_ENABLED)
			Log.d( ZzishExtension.ID + "::" + TAG, message );
	}
	
	public static void handleException( FREContext context, Exception e )
	{
		if (DEBUG_ENABLED) 
			e.printStackTrace();
		
		if (context != null)
			context.dispatchStatusEventAsync( ExtensionEvent.ERROR, e.getMessage() );
	}

	
	
	public static String[] GetObjectAsArrayOfStrings( FREArray values )
	{
		try
		{
			int length = (int)values.getLength();
			String[] retArray = new String[length];

			for (int i = 0; i < length; i++)
			{
				FREObject value = values.getObjectAt(i);
				retArray[i] = value.getAsString();
			}

			return retArray;
		}
		catch (Exception e)
		{
		}
		return new String[0];
	}
	
	
	public static int[] GetObjectAsArrayOfNumbers( FREArray values )
	{
		try
		{
			int length = (int)values.getLength();
			int[] retArray = new int[length];

			for (int i = 0; i < length; i++)
			{
				FREObject value = values.getObjectAt(i);
				retArray[i] = value.getAsInt();
			}

			return retArray;
		}
		catch (Exception e)
		{
		}
		return new int[0];
	}	
	
	
	////////////////////////////////////////////////////////////
	//	VIEW HELPERS
	//
	
	public static void moveToBack( View currentView ) 
	{
		ViewGroup vg = ((ViewGroup) currentView.getParent());
		int index = vg.indexOfChild(currentView);
		for(int i = 0; i<index; i++)
		{
			vg.bringChildToFront(vg.getChildAt(0));
		}
	}
}
