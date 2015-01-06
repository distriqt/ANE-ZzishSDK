//
//  ZZActivity.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZzishActivity.h"
#import "ZzishUser.h"
#import "ZzishService.h"

@implementation ZzishActivity

- (void)startWithBlock: (void (^) (NSDictionary *response)) block {
    [ZzishService sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/start" withAction:nil withBlock:block];
}

- (void)stopWithBlock: (void (^) (NSDictionary *response)) block {
    [ZzishService sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/complete" withAction:nil withBlock:block];
}

- (void)cancelWithBlock: (void (^) (NSDictionary *response)) block {
    [ZzishService sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/cancel" withAction:nil withBlock:block];
}

- (ZzishAction *)createAction:(NSString *)name {
    ZzishAction* action = [[ZzishAction alloc] init];
    action.name = name;
    action.uuid = [[NSUUID UUID] UUIDString];
    action.activity = self;
    return action;
}

- (NSDictionary *)tincan {
    NSMutableDictionary *activity = [NSMutableDictionary new];
    if (self.name) {
        NSMutableDictionary *activityDefinition = [NSMutableDictionary new];
        activityDefinition[@"type"] = self.name;
        activity[@"definition"] = activityDefinition;
    }
    
    if ([self.attributes count]>0) {
        NSMutableDictionary *activityState = [NSMutableDictionary new];
        activityState[@"attributes" ] = self.attributes;
        activity[@"state"] = activityState;
    }
    return activity;
}

@end
