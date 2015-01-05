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
 * @file   		Zzish.m
 * @brief  		ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */


#import "FlashRuntimeExtensions.h"
#import "DTZZFREUtils.h"
#import "DTZZController.h"
#import "DTZZUtils.h"

NSString * const Zzish_VERSION = @"1.0";
NSString * const Zzish_IMPLEMENTATION = @"iOS";

FREContext distriqt_zzish_ctx = nil;
DTZZController* distriqt_zzish_controller = nil;
Boolean distriqt_zzish_v = false;


////////////////////////////////////////////////////////
//	ACTIONSCRIPT INTERFACE METHODS 
//

FREObject ZzishVersion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        FRENewObjectFromUTF8( (uint32_t)strlen((const char*)[Zzish_VERSION UTF8String]) + 1, (const uint8_t*)[Zzish_VERSION UTF8String], &result);
    }
    return result;
}


FREObject ZzishImplementation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        FRENewObjectFromUTF8( (uint32_t)strlen((const char*)[Zzish_IMPLEMENTATION UTF8String]) + 1, (const uint8_t*)[Zzish_IMPLEMENTATION UTF8String], &result);
    }
    return result;
}


FREObject ZzishIsSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        FRENewObjectFromBool( [DTZZController isSupported], &result);
    }
    return result;
}


FREObject ZzishStartWithApplicationId(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        NSString* applicationId = [DTZZFREUtils getFREObjectAsString: argv[0]];
        [distriqt_zzish_controller startWithApplicationId: applicationId];
    }
    return result;
}


FREObject ZzishCreateUser(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        [DTZZFREUtils log: @"ZzishCreateUser"];
        NSString* userId = [DTZZFREUtils getFREObjectAsString: argv[0]];
        
        ZzishUser* user  = [distriqt_zzish_controller createUser: userId];
        
        result = [DTZZUtils freObjectFromZzishUser: user];
        [DTZZFREUtils setFREObjectProperty: @"userId"
                                    object: result
                                     value: [DTZZFREUtils newFREObjectFromString: userId]];
    }
    return result;
}


FREObject Zzish_User_CreateActivity(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        NSString* userId = [DTZZFREUtils getFREObjectPropertyAsString: @"userId" object:argv[0]];
        NSString* activityName = [DTZZFREUtils getFREObjectAsString: argv[1]];
        
        [DTZZFREUtils log: @"Zzish_User_CreateActivity:: [%@] %@", userId, activityName ];

        ZzishUser* user = [distriqt_zzish_controller createUser: userId];
        
        ZzishActivity* activity = [user createActivity: activityName];
        
        NSString* activityId = [distriqt_zzish_controller storeActivity: activity];
        
        result = [DTZZUtils freObjectFromZzishActivity: activity
                                            activityId: activityId];
    
    }
    return result;
}


FREObject Zzish_User_SetName(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        NSString* userId = [DTZZFREUtils getFREObjectPropertyAsString: @"userId" object:argv[0]];
        NSString* name   = [DTZZFREUtils getFREObjectAsString: argv[1]];

        [DTZZFREUtils log: @"Zzish_User_SetName:: [%@] %@", userId, name];
        
        ZzishUser* user = [distriqt_zzish_controller createUser: userId];
        user.name = name;
        
        result = [DTZZFREUtils newFREObjectFromBoolean: true];
    }
    return result;
}


FREObject Zzish_Activity_Start(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        NSString* activityId    = [DTZZFREUtils getFREObjectPropertyAsString: @"id" object: argv[0]];
//        NSString* name          = [DTZZFREUtils getFREObjectPropertyAsString: @"name" object: argv[0]];
        NSString* groupCode     = [DTZZFREUtils getFREObjectPropertyAsString: @"groupCode" object: argv[0]];

        [DTZZFREUtils log: @"Zzish_Activity_Start:: [%@] groupCode=%@", activityId, groupCode];

        ZzishActivity* activity = [distriqt_zzish_controller getActivity: activityId];
        
        if (activity != nil)
        {
            activity.groupCode = groupCode;
        
            [activity start];
        }
    }
    return result;
}


FREObject Zzish_Activity_Stop(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        [DTZZFREUtils log: @"Zzish_Activity_Stop"];
        NSString* activityId    = [DTZZFREUtils getFREObjectPropertyAsString: @"id" object: argv[0]];
        
        ZzishActivity* activity = [distriqt_zzish_controller getActivity: activityId];
        
        if (activity != nil)
        {
            [activity stop];
        }
    }
    return result;
}


FREObject Zzish_Activity_Cancel(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        [DTZZFREUtils log: @"Zzish_Activity_Cancel"];
        NSString* activityId    = [DTZZFREUtils getFREObjectPropertyAsString: @"id" object: argv[0]];
        
        ZzishActivity* activity = [distriqt_zzish_controller getActivity: activityId];
        
        if (activity != nil)
        {
            [activity cancel];
        }
    }
    return result;
}


FREObject Zzish_Activity_CreateAction(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        [DTZZFREUtils log: @"Zzish_Activity_CreateAction"];
        NSString* activityId    = [DTZZFREUtils getFREObjectPropertyAsString: @"id" object: argv[0]];
        NSString* actionName    = [DTZZFREUtils getFREObjectAsString: argv[1]];
        
        ZzishActivity* activity = [distriqt_zzish_controller getActivity: activityId];
        
        if (activity != nil)
        {
            ZzishAction* action = [activity createAction: actionName];
            
            NSString* actionId = [distriqt_zzish_controller storeAction: action];
            
            result = [DTZZUtils freObjectFromZzishAction: action
                                                actionId: actionId];
        }
    }
    return result;
}


FREObject Zzish_Action_Save(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject result = NULL;
    @autoreleasepool
    {
        [DTZZFREUtils log: @"Zzish_Action_Save"];
        NSString* actionId  = [DTZZFREUtils getFREObjectPropertyAsString: @"id" object: argv[0]];
        
        int attempts        = [DTZZFREUtils getFREObjectPropertyAsInt: @"attempts" object: argv[0]];
        Boolean correct     = [DTZZFREUtils getFREObjectPropertyAsBoolean: @"correct" object: argv[0]];
        double duration     = [DTZZFREUtils getFREObjectPropertyAsDouble: @"duration" object: argv[0]];
        NSString* response  = [DTZZFREUtils getFREObjectPropertyAsString: @"response" object: argv[0]];
        double score        = [DTZZFREUtils getFREObjectPropertyAsDouble: @"score" object: argv[0]];
        
        ZzishAction* action = [distriqt_zzish_controller getAction: actionId];
        
        if (action != nil)
        {
            action.attempts = attempts;
            action.correct  = (correct ? YES : NO);
            action.duration = (long) duration;
            action.response = response;
            action.score    = (float)score;
            
            [action save];
        }
        
    }
    return result;
}



////////////////////////////////////////////////////////
// FRE CONTEXT 
//

void ZzishContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    [DTZZFREUtils setLogTag: @"com.distriqt.Zzish"];

    //
	//	Add the ACTIONSCRIPT interface
	
	static FRENamedFunction distriqt_zzishFunctionMap[] =
    {
        MAP_FUNCTION( ZzishVersion,                 "version",                  NULL ),
        MAP_FUNCTION( ZzishImplementation,          "implementation",           NULL ),
        MAP_FUNCTION( ZzishIsSupported,             "isSupported",              NULL ),
        
        MAP_FUNCTION( ZzishStartWithApplicationId,  "startWithApplicationId",   NULL ),
        MAP_FUNCTION( ZzishCreateUser,              "createUser",               NULL ),
        
        MAP_FUNCTION( Zzish_User_CreateActivity,    "user_createActivity",      NULL ),
        MAP_FUNCTION( Zzish_User_SetName,           "user_setName",      NULL ),
        
        MAP_FUNCTION( Zzish_Activity_Start,         "activity_start",           NULL ),
        MAP_FUNCTION( Zzish_Activity_Stop,          "activity_stop",            NULL ),
        MAP_FUNCTION( Zzish_Activity_Cancel,        "activity_cancel",          NULL ),
        MAP_FUNCTION( Zzish_Activity_CreateAction,  "activity_createAction",    NULL ),
        
        MAP_FUNCTION( Zzish_Action_Save,            "action_save",              NULL )
    
    };
    
    *numFunctionsToTest = sizeof( distriqt_zzishFunctionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = distriqt_zzishFunctionMap;
    
	
	//
	//	Store the global states
	
    distriqt_zzish_ctx = ctx;
    
    distriqt_zzish_controller = [[DTZZController alloc] init];
    distriqt_zzish_controller.context = distriqt_zzish_ctx;
	
}


/**	
 *	The context finalizer is called when the extension's ActionScript code calls the ExtensionContext instance's dispose() method. 
 *	If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ZzishContextFinalizer(FREContext ctx) 
{
	distriqt_zzish_ctx = nil;
}


/**
 *	The extension initializer is called the first time the ActionScript
 *		side of the extension calls ExtensionContext.createExtensionContext() 
 *		for any context.
 */
void ZzishExtInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &ZzishContextInitializer;
	*ctxFinalizerToSet   = &ZzishContextFinalizer;
} 


/**
 *	The extension finalizer is called when the runtime unloads the extension. However, it is not always called.
 */
void ZzishExtFinalizer( void* extData ) 
{
	// Nothing to clean up.	
}

