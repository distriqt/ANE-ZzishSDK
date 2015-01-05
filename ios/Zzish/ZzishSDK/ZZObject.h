//
//  ZZObject is the object that all Zzish objects inherit from
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
//#import "JSONModel.h"

@interface ZZObject : NSObject

@property (strong,nonatomic) NSString* uuid;

/*!
 * @discussion adds a string attribute for a particular key. Will be ignored if there are already MAX_KEYS added
 * @param value NSString value
 * @param key NSString key
 */
- (void)setValue:(NSString *)value forKey:(NSString *)key;

/*!
 * @discussion returns value for key
 * @param key NSString key 
 * @return The value of the key in dictionary
 */
- (NSString *)valueForKey:(NSString *)key;

/*!
 * @discussion returns the attributes dictionary copy
 * @return The attributes dictionary
 */
- (NSDictionary *)attributes;


/*!
 * @discussion saves the ZZobject. Updates it if already exists. Uploads to server if connected
 */
- (void)save;

@end
