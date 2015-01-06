//
//  ZZAction.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZzishAction.h"
#import "ZzishActivity.h"
#import "ZzishService.h"

@interface ZzishAction()

@property (strong,nonatomic) NSNumber* scoreObject;
@property (strong,nonatomic) NSNumber* durationObject;
@property (nonatomic,nonatomic) NSNumber* correctObject;
@property (nonatomic,nonatomic) NSNumber* attemptsObject;

@end

@implementation ZzishAction

- (ZzishAction *)score:(float)score {
    self.scoreObject = [NSNumber numberWithFloat:score];
    return self;
}

- (ZzishAction *)duration:(long)duration {
    self.durationObject = [NSNumber numberWithLong:duration];
    return self;
}

- (ZzishAction *)correct:(BOOL)correct {
    self.correctObject = [NSNumber numberWithBool:correct];
    return self;
}

- (ZzishAction *)attempts:(int)attempts {
    self.attemptsObject = [NSNumber numberWithInt:attempts];
    return self;
}

- (ZzishAction *)response:(NSString*)response {
    self.response = response;
    return self;
}

- (void)setScore:(float)score {
    [self score:score];
}

- (void)setDuration:(long)duration {
    [self duration:duration];
}

- (void)setAttempts:(int)attempts {
    [self attempts:attempts];
}

- (void)setCorrect:(BOOL)correct {
    [self correct:correct];
}

- (float)score {
    return [self.scoreObject floatValue];
}

- (long)duration {
    return [self.durationObject longLongValue];
}

- (int)attempts {
    return [self.attemptsObject intValue];
}

- (BOOL)correct {
    return [self.correctObject boolValue];
}

- (void)saveWithBlock: (void (^) (NSDictionary *response)) block {
    [ZzishService sendMessage:self.activity.user withActivivity:self.activity forVerb:@"http://activitystrea.ms/schema/1.0/start" withAction:self withBlock:block];
}

- (NSDictionary *)tincan {
    NSMutableDictionary *action = [NSMutableDictionary new];
    if (self.scoreObject) action[@"score"] = self.scoreObject;
    if (self.durationObject) action[@"duration"] = self.durationObject;
    if (self.correctObject) {
        int x = [self.correctObject intValue];
        action[@"correct"] = x==1?@"true":@"false";
    }
    if (self.attemptsObject) action[@"attempts"] = self.attemptsObject;
    if (self.response) action[@"response"] = self.response;
    
    NSMutableDictionary *actionDefinition = [NSMutableDictionary new];
    actionDefinition[@"type"] = self.name;
    action[@"definition"] = actionDefinition;
    action[@"uuid"] = self.uuid;
    
    if ([self.attributes count]>0) {
        NSMutableDictionary *actionState = [NSMutableDictionary new];
        actionState[@"attributes" ]= self.attributes;
        action[@"state"] = actionState;
    }
    return action;
}


@end
