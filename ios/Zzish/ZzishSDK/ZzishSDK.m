//
//  ZzishSDK.m
//  Pods
//
//  Created by Samir Seetal on 04/12/2014.
//
//

#import "ZzishSDK.h"

//#import "Reachability.h"
//#import "sqlite3.h"
//
//
//
//
//static sqlite3 *database;
//
////    [ZZService open];
////    NSLog(@"Are you connected %d",[ZZService connected]);
////    NSString* name = @"ZZUser";
////    NSMutableDictionary* values = [NSMutableDictionary new];
////    values[@"firstName"] = @"John";
////    values[@"lastName"] = @"Paul";
////    values[@"serverId"] = @"12345";
////    values[@"identifier"] = [NSNumber numberWithInteger:1];
////    NSString* value;
////    NSError *error;
////    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:values
////                                                       options:(NSJSONWritingOptions)0
////                                                         error:&error];
////
////    if (! jsonData) {
////        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
////        value = @"{}";
////    } else {
////        value =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
////    }
////
////    JSONModelError* jerror;
////    Class class = NSClassFromString(name);
////    NSLog(@"Class is %@",class);
////    ZZUser* myClassObject = (ZZUser *)[[class alloc] initWithString:value error:&jerror];
////    NSLog(@"Error is %@",error);
////    NSLog(@"The name is %@",myClassObject);
//
//+ (NSString* ) databasePath {
//    NSString *docsDir;
//    NSArray *dirPaths;
//    // Get the documents directory
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    docsDir = [dirPaths objectAtIndex:0];
//    return [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"ZZISHDB"]];
//}
//
//+ (const char*) databasename {
//    return [[self databasePath] UTF8String];
//}
//
//+ (void)open {
//    if (sqlite3_open([self databasename], &database) != SQLITE_OK) {
//        NSLog(@"Failed to open database! %s", sqlite3_errmsg(database));
//    }
//    NSLog(@"YES");
//}
//
//+ (BOOL)connected {
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
//    return networkStatus != NotReachable;
////    return NO;
//}

@implementation ZzishSDK



@end
