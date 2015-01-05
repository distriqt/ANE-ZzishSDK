//
//  PropertyService.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZPropertyService.h"


@implementation ZZPropertyService

#define PREF_FILE_NAME @"ZZISHPREFERENCES"

#define APP_TOKEN @"appToken"
#define DEVICE_ID @"deviceId"
#define SESSION_ID @"sessionId"
#define USER_ID @"userId"

+ (void)setAppToken:(NSString *)appToken {
    [self setData:APP_TOKEN withValue:appToken];
}

+ (void)setDeviceId:(NSString *)deviceId {
    [self setData:DEVICE_ID withValue:deviceId];
}

+ (void)setSessionId:(NSString *)sessionId {
    [self setData:SESSION_ID withValue:sessionId];
}

+ (void)setUserId:(NSString *)userId {
    [self setData:USER_ID withValue:userId];
}

+ (NSString *)userId {
    return [self data:USER_ID];
}

+ (NSString *)sessionId {
    return [self data:SESSION_ID];
}

+ (NSString *)deviceId {
    return [self data:DEVICE_ID];
}

+ (NSString *)appToken {
        return [self data:APP_TOKEN];
}

+ (NSString *)fileName {
    return PREF_FILE_NAME;
}



@end
