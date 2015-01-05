//
//  DTZZUtils.h
//  Zzish
//
//  Created by Michael Archbold on 31/12/2014.
//  Copyright (c) 2014 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzishSDK/ZzishSDK.h"

@interface DTZZUtils : NSObject


+(FREObject) freObjectFromZzishUser: (ZzishUser*) user;

+(FREObject) freObjectFromZzishActivity: (ZzishActivity*) activity activityId: (NSString*) activityId;

+(FREObject) freObjectFromZzishAction: (ZzishAction*) action actionId: (NSString*) actionId;


@end
