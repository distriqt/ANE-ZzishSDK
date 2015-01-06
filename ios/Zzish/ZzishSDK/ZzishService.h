//
//  ZZService.h
//  Pods
//
//  Created by Samir Seetal on 27/11/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZzishUser.h"
#import "ZzishActivity.h"
#import "ZzishAction.h"
#import "ZZWebService.h"

@interface ZzishService : NSObject

+ (void)startWithApplicationId:(NSString *)applicationId withBlock: (void (^) (NSDictionary *response)) block;
+ (ZzishUser *)user:(NSString *)user;
+ (void)saveUser:(ZzishUser*)user withBlock: (void (^) (NSDictionary *response)) block;
+ (void)sendMessage:(ZzishUser *)user withActivivity:(ZzishActivity *)activity forVerb:(NSString *)verbName withAction:(ZzishAction*)action withBlock: (void (^) (NSDictionary *response)) block;
+ (BOOL)connected;

@end
