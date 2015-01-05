//
//  ZZUser.h
//  Pods
//
//  Created by Samir Seetal on 04/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
#import "ZzishActivity.h"

@interface ZzishUser : ZZObject

/*!
 * @discussion The name of the user
 */
@property (strong, nonatomic) NSString* name;

/*!
 * @discussion Returns the current user
 * @return the current User (or nill) if never set
 */
+ (ZzishUser *) currentUser;

/*!
 * @discussion Create an activity for this user
 * @param name The name of the activity
 */
- (ZzishActivity *) createActivity:(NSString *)name;

/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
