//
//  ZZObject.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZObject.h"
#define MAX_MAP_SIZE 5
#import "ZZDataService.h"

@interface ZZObject()

///List of attributes to upload for object
@property (strong,nonatomic) NSMutableDictionary* dictionary;

@end


@implementation ZZObject

- (NSMutableDictionary *)dictionary {
    if (!_dictionary) {
        _dictionary = [NSMutableDictionary new];
    }
    return _dictionary;
}

- (void)setValue:(NSString *)value forKey:(NSString *)key {
    if ([self.dictionary count]<MAX_MAP_SIZE || self.dictionary[key]) {
        [self.dictionary setValue:value forKey:key];
    }
}

- (NSString *)valueForKey:(NSString *)key {
    return [self.dictionary valueForKey:key];
}

- (NSDictionary *)attributes {
    return [self.dictionary copy];
}

- (void)saveWithBlock: (void (^) (NSDictionary *response)) block {
    [ZZDataService save:self];
}

@end
