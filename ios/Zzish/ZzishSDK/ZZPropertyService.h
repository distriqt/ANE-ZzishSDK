//
//  PropertyService.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZFileService.h"

@interface ZZPropertyService : ZZFileService

/*!
 * @discussion Sets the app token in preference file
 */
+ (void)setAppToken:(NSString *)appToken;

/*!
 * @discussion Sets the device id in preference file
 */
+ (void)setDeviceId:(NSString *)deviceId;

/*!
 * @discussion Sets the session id in preference file
 */
+ (void)setSessionId:(NSString *)sessionId;

/*!
 * @discussion Sets the user id in preference file
 */
+ (void)setUserId:(NSString *)userId;

/*!
 * @discussion returns the user id from preference file
 * @return user Id
 */
+ (NSString *)userId;

/*!
 * @discussion returns the sessionId from preference file
 * @return session Id
 */
+ (NSString *)sessionId;

/*!
 * @discussion returns the deviceId from preference file
 * @return device Id
 */
+ (NSString *)deviceId;

/*!
 * @discussion returns the appToken from preference file
 * @return appToken
 */
+ (NSString *)appToken;

@end
