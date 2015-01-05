//
//  DTZZController.m
//  Zzish
//
//  Created by Michael Archbold on 31/12/2014.
//  Copyright (c) 2014 distriqt. All rights reserved.
//

#import "DTZZController.h"

#import "ZzishSDK/ZzishSDK.h"

@implementation DTZZController

@synthesize context;


+(Boolean) isSupported
{
    return true;
}



-(id)init
{
    self = [super init];
    if (self)
    {
        _users      = [[NSMutableArray alloc] init];
        _activities = [[NSMutableArray alloc] init];
        _actions    = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void) dealloc
{
    _users = nil;
    _activities = nil;
    _actions = nil;
}


-(void) startWithApplicationId: (NSString*) applicationId
{
    [DTZZFREUtils log: @"DTZZController::startWithApplicationId: %@", applicationId];
    
    [Zzish delegate: self];
    [Zzish startWithApplicationId: applicationId];
}


-(ZzishUser*) createUser: (NSString*) userId
{
    [DTZZFREUtils log: @"DTZZController::createUser: %@", userId ];
    return [Zzish user: userId];
}



#pragma mark - Activity Helpers

-(NSString*) storeActivity: (ZzishActivity*) activity
{
    NSString* activityId = [NSString stringWithFormat: @"%ld", (unsigned long)_activities.count];
    [_activities addObject: activity];
    return  activityId;
}


-(ZzishActivity*) getActivity: (NSString*) activityId
{
    NSInteger index = [activityId integerValue];
    if (index >= 0 && index < _activities.count)
    {
        return [_activities objectAtIndex: index];
    }
    return nil;
}


#pragma mark - Action Helpers

-(NSString*) storeAction: (ZzishAction*) action
{
    NSString* actionId = [NSString stringWithFormat: @"%ld", (unsigned long)_actions.count];
    [_actions addObject: action];
    return actionId;
}


-(ZzishAction*) getAction: (NSString*) actionId
{
    NSInteger index = [actionId integerValue];
    if (index >= 0 && index < _actions.count)
    {
        return [_actions objectAtIndex: index];
    }
    return nil;
}



#pragma mark - ZZCallbackDelegate


-(void) processZzishResponse:(int)status andMessage:(NSString *)message
{
    [DTZZFREUtils log: @"DTZZController::processZzishResponse: %d andMessage: %@", status, message ];
}




@end
