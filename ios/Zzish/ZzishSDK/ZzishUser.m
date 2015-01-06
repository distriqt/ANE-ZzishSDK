//
//  ZZUser.m
//  Pods
//
//  Created by Samir Seetal on 04/12/2014.
//
//

#import "ZzishUser.h"
#import "ZZPropertyService.h"
#import "ZzishService.h"

@implementation ZzishUser

/*!
 * @discussion Upload contents to serve
 */
- (void)saveWithBlock: (void (^) (NSDictionary *response)) block {
    [ZzishService saveUser:self withBlock:block];
}

+ (ZzishUser *) currentUser {
    NSString* currentUserId = [ZZPropertyService userId];
    if (currentUserId) {
        //userId is new or changed
        ZzishUser* user = [[ZzishUser alloc] init];
        user.uuid = currentUserId;
        return user;
    }
    return nil;
}

- (ZzishActivity *) createActivity:(NSString *)name {
    ZzishActivity* activity = [[ZzishActivity alloc] init];
    activity.uuid = [[NSUUID UUID] UUIDString];
    activity.name = name;
    activity.user = self;
    return activity;
}

- (NSDictionary *)tincan {
    NSMutableDictionary *actor = [NSMutableDictionary new];
    if (self.name) {
        actor[@"name"] = self.name;
    }
    
    NSMutableDictionary *account = [NSMutableDictionary new];
    account[@"homePage"] = [NSString stringWithFormat:@"http://www.zzish.com/%@",[ZZPropertyService appToken]];
    account[@"name"] = self.uuid;
    actor[@"account"] = account;
    return actor;
}

@end
