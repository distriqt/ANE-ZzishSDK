//
//  ZZService.m
//  Pods
//
//  Created by Samir Seetal on 27/11/2014.
//
//

#import "ZzishService.h"
#import "ZZPropertyService.h"
#import "ZZWebService.h"
#import "ZzishSDK.h"
#import "ZZJsonService.h"

@interface ZzishService()

@property (strong,nonatomic) ZZWebService* wservice;

@end

@implementation ZzishService

@synthesize delegate;

static ZzishService *instance;
static dispatch_once_t predicate = 0;

+ (void)startWithApplicationId:(NSString *)applicationId {
    if (!instance) {
        predicate = 0;
        dispatch_once(&predicate, ^{
            instance = [[self alloc] init];
            
            if (![ZZPropertyService deviceId]) {
                [ZZPropertyService setDeviceId:[[NSUUID UUID] UUIDString]];
            }
            [ZZPropertyService setAppToken:applicationId];
            //instatiate webservice 
            instance.wservice = [[ZZWebService alloc] init];
            instance.wservice.delegate = instance;
        });
    }
}

+ (ZzishUser *)user:(NSString *)uuid {
    NSString* currentUserId = [ZZPropertyService userId];
    if (!currentUserId || ![uuid isEqualToString:currentUserId]) {
        //userId is new or changed
        [ZZPropertyService setSessionId:[[NSUUID UUID] UUIDString]];
    }
    [ZZPropertyService setUserId:uuid];
    ZzishUser* user = [[ZzishUser alloc] init];
    user.uuid = uuid;
    return user;
}

+ (void)sendMessage:(ZzishUser *)userModel withActivivity:(ZzishActivity *)activityModel forVerb:(NSString *)verbName withAction:(ZzishAction*)actionModel {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"id"] = activityModel.uuid;
    dictionary[@"actor"] = [userModel tincan];
    
    NSMutableDictionary *verb = [NSMutableDictionary new];
    verb[@"id"] = verbName;
    dictionary[@"verb"] = verb;
    
    dictionary[@"object"] = [activityModel tincan];

    if (actionModel) {
        dictionary[@"actions"] = @[[actionModel tincan]];
    }
    NSMutableDictionary *context = [NSMutableDictionary new];
    NSMutableDictionary *extensions = [NSMutableDictionary new];
    if (activityModel.groupCode) {
        extensions[@"http://www.zzish.com/context/extension/groupCode"]=activityModel.groupCode;
    }
    if ([ZZPropertyService deviceId]) {
        extensions[@"http://www.zzish.com/context/extension/deviceId"]=[ZZPropertyService deviceId];
    }
    if ([ZZPropertyService sessionId]) {
        extensions[@"http://www.zzish.com/context/extension/sessionId"]=[ZZPropertyService sessionId];
    }
    context[@"extensions"] = extensions;
    dictionary[@"context"] = context;

    [self uploadDictionary:dictionary toEndPoint:@"statements"];
    
    

}

+ (void)saveUser:(ZzishUser*)user {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"name"] = user.name;
    dictionary[@"uuid"] = user.uuid;
    [ZzishService uploadDictionary:dictionary toEndPoint:@"profiles"];
}

+ (void)uploadDictionary:(NSDictionary *)dictionary toEndPoint:(NSString *)endpoint {
    NSMutableDictionary* toPost = [NSMutableDictionary new];
    toPost[ENDPOINT_PARAM] = endpoint;

    
    NSError *error;
    NSData *jsonOutputData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                             options:NSJSONWritingPrettyPrinted
                                                               error:&error];
    
    
    //set json string to body data
    NSString *jsonOutputString = [[NSString alloc] initWithData:jsonOutputData encoding:NSUTF8StringEncoding];
    toPost[DATA_PARAM] = jsonOutputString;

    if ([ZzishSDK connected]) {
        NSDictionary *firstToSend = [ZZJsonService saveRequest:toPost andReturn:YES];
        NSLog(@"Connected Sending %@",firstToSend);
        //connected so we can send message
        [instance.wservice upload:firstToSend];
    }
    else {
        [ZZJsonService saveRequest:toPost andReturn:NO];
    }
}

+ (void)delegate:(id)delegate {
    instance.delegate = delegate;
}

- (void) process: (NSDictionary *)dictionary {
    NSLog(@"Processing Response %@",dictionary);
    int status = [dictionary[@"status"] intValue];
    //check to see if there are any other messages to send. If there are not, finish
    NSDictionary *next = [ZZJsonService next];
    if (next) {
        [instance.wservice upload:next];
    }
    else {
        NSString* message = @"";
        if(![dictionary[@"message"] isEqual:[NSNull null]])
        {
            message = dictionary[@"message"];
            //do something if object is not equals to [NSNull null]
        }
        [self.delegate processZzishResponse:status andMessage:message];
    }
}

@end
