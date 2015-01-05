//
//  FileService.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZFileService.h"

@implementation ZZFileService

+ (NSString *) fileName {
    return nil;
}

+ (id)data:(NSString *)key {
    return [[NSDictionary dictionaryWithContentsOfFile:[self filePath]] valueForKey:key];
}

+ (void)setData:(NSString *)key withValue:(id) value {
    if (value) {
        NSMutableDictionary* dict = [self dictionary];
        [dict setValue:value forKey:key];
        [self savePropertyList:dict];
    }
    else {
        [self removeDataForKey:key];
    }
}

+ (NSString *)removeDataForKey:(NSString *)key
{
    NSMutableDictionary *dict = [self dictionary];
    NSString* value = dict[key];
    [dict removeObjectForKey:key];
    [self savePropertyList:dict];
    return value;
}

/*!
 * @discussion Determine the path where preference is stored
 * @return absolute path of preference file
 */
+ (NSString *) filePath {
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString* fileName = [self fileName];
    return [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: fileName]];
}



/*!
 * @discussion Returns a mutable dictionary or creates a new one
 * @param key The key to be searched for
 * @return the value from preference file
 */
+ (NSMutableDictionary *) dictionary {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
    if (dict==nil) {
        dict = [[NSMutableDictionary alloc] init];
    }
    return dict;
}

/*!
 * @discussion Saves the property (after an update)
 * @param pList All the parameters to save
 */
+ (void) savePropertyList:(NSMutableDictionary *) plist {
    [plist writeToFile:[self filePath] atomically: YES];
}

@end
