//
//  ZZActivity.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
#import "ZzishAction.h"
@class ZzishUser;

@interface ZzishActivity : ZZObject

/*!
 * @discussion The name of the activity
 */
@property (strong, nonatomic) NSString* name;
/*!
 * @discussion The Zzish Class Code for the activity
 */
@property (strong, nonatomic) NSString* groupCode;
/*!
 * @discussion The user that created this activity
 */
@property (strong, nonatomic) ZzishUser* user;

/*!
 * @discussion Start the activity
 * @param An optional block to process response when method is finished
 */
- (void)startWithBlock: (void (^) (NSDictionary *response)) block;

/*!
 * @discussion Stop the activity
 * @param An optional block to process response when method is finished
 */
- (void)stopWithBlock: (void (^) (NSDictionary *response)) block;

/*!
 * @discussion Cancel the activity
 * @param An optional block to process response when method is finished
 */
- (void)cancelWithBlock: (void (^) (NSDictionary *response)) block;

/*!
 * @discussion Create an action for this activity
 * @param name The name of the action
 */
- (ZzishAction *)createAction:(NSString *)name;

/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
