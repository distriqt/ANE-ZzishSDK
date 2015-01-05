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
 * @file   		ZzishExtension.java
 * @brief  		Main Extension implementation for this ANE
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.zzish;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class ZzishExtension implements FREExtension 
{
	public static FREContext context;
	
	public static String ID	= "com.distriqt.Zzish";
	
	
	@Override
	public FREContext createContext(String arg0) 
	{
		return context = new ZzishContext();
	}

	@Override
	public void dispose() 
	{
		context = null;
	}

	@Override
	public void initialize() 
	{
	}

}
