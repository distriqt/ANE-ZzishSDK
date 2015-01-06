//
//  WebService.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZCallback.h"

@interface ZZWebService : NSObject<NSURLConnectionDelegate>

- (void)upload:(NSDictionary*)command withBlock: (void (^) (NSDictionary *response)) block;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse;

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end

