//
//  ZZDataService.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZDataService.h"

#define CLASS_NAME @"CLASS_NAME"
#define OBJECT_VALUE @"OBJECT_VALUE"
#define FILE_NAME @"ZZISHDB"

@implementation ZZDataService

+ (NSString *)save:(ZZObject *)model {
    NSError* error;
    NSMutableDictionary* overall = [NSMutableDictionary new];
    overall[CLASS_NAME] = NSStringFromClass ([model class]);
    //overall[OBJECT_VALUE] = [model toDictionary];
    NSData *jsonOutputData = [NSJSONSerialization dataWithJSONObject:overall
                                                             options:NSJSONWritingPrettyPrinted
                                                               error:&error];
    //set json string to body data
    NSString *jsonOutputString = [[NSString alloc] initWithData:jsonOutputData encoding:NSUTF8StringEncoding];
    [self setData:model.uuid withValue:jsonOutputString];
    return jsonOutputString;
}

+ (ZZObject *)get:(NSString *)uuid {
    if ([self data:uuid]) {
        NSData *data = [[self data:uuid] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary* modelObject = dictionary[OBJECT_VALUE];
        Class class = NSClassFromString(dictionary[CLASS_NAME]);
        return (ZZObject *)[[class alloc] initWithDictionary:modelObject];
    }
    return nil;
}

+ (NSString *)fileName {
    return FILE_NAME;
}



@end
