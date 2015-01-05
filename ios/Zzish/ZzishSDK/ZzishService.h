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

@protocol ZZCallbackDelegate <NSObject>
@required
- (void) processZzishResponse:(int)status andMessage:(NSString *)message;
@end

@interface ZzishService : NSObject<ZZWebCallbackDelegate>
{
    id <ZZCallbackDelegate> delegate;
}

@property (retain) id delegate;

+ (void)startWithApplicationId:(NSString *)applicationId;
+ (ZzishUser *)user:(NSString *)user;
+ (void)delegate:(id)delegate;

+ (void)saveUser:(ZzishUser*)user;
+ (void)sendMessage:(ZzishUser *)user withActivivity:(ZzishActivity *)activity forVerb:(NSString *)verbName withAction:(ZzishAction*)action;

@end
