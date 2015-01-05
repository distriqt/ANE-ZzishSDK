//
//  DTZZController.h
//  Zzish
//
//  Created by Michael Archbold on 31/12/2014.
//  Copyright (c) 2014 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzishSDK/ZzishSDK.h"

@interface DTZZController : NSObject <ZZCallbackDelegate>
{
    NSMutableArray* _users;
    NSMutableArray* _activities;
    NSMutableArray* _actions;
}


@property FREContext context;

+(Boolean) isSupported;



-(void) startWithApplicationId: (NSString*) applicationId;

-(ZzishUser*) createUser: (NSString*) userId;



//
//  ACTIVITIES
//

-(NSString*) storeActivity: (ZzishActivity*) activity;
-(ZzishActivity*) getActivity: (NSString*) activityId;


//
//  ACTIONS
//

-(NSString*) storeAction: (ZzishAction*) action;
-(ZzishAction*) getAction: (NSString*) actionId;


@end
