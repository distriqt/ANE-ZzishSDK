//
//  DTZZUtils.m
//  Zzish
//
//  Created by Michael Archbold on 31/12/2014.
//  Copyright (c) 2014 distriqt. All rights reserved.
//

#import "DTZZUtils.h"
#import "DTZZFREUtils.h"

@implementation DTZZUtils


+(FREObject) freObjectFromZzishUser: (ZzishUser*) user
{
    FREObject result = NULL;
    
    result = [DTZZFREUtils newFREObject];
    
    NSString* username = (user.name != nil) ? user.name : @"";
    
    [DTZZFREUtils setFREObjectProperty: @"name"
                                object: result
                                 value: [DTZZFREUtils newFREObjectFromString: username]];
    
    return result;
}


+(FREObject) freObjectFromZzishActivity: (ZzishActivity*) activity activityId: (NSString*) activityId
{
    FREObject result = NULL;
    result = [DTZZFREUtils newFREObject];
    
    [DTZZFREUtils setFREObjectProperty: @"id"
                                object: result
                                 value: [DTZZFREUtils newFREObjectFromString: activityId]];
    
    [DTZZFREUtils setFREObjectProperty: @"name"
                                object: result
                                 value: [DTZZFREUtils newFREObjectFromString: activity.name]];
    
    [DTZZFREUtils setFREObjectProperty: @"groupCode"
                                object: result
                                 value: [DTZZFREUtils newFREObjectFromString: activity.groupCode]];
    
    
    return result;
}


+(FREObject) freObjectFromZzishAction: (ZzishAction*) action actionId: (NSString*) actionId
{
    FREObject result = NULL;
    result = [DTZZFREUtils newFREObject];
    
    [DTZZFREUtils setFREObjectProperty: @"id"
                                object: result
                                 value: [DTZZFREUtils newFREObjectFromString: actionId]];
    
    [DTZZFREUtils setFREObjectProperty: @"name"
                                object: result
                                 value: [DTZZFREUtils newFREObjectFromString: action.name]];
    
//    [DTZZFREUtils setFREObjectProperty: @"groupCode"
//                                object: result
//                                 value: [DTZZFREUtils newFREObjectFromString: ]];
    
    
    return result;
}


@end
