//
//  WebService.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZCallback.h"

@protocol ZZWebCallbackDelegate <NSObject>
@required
- (void) process: (NSDictionary *)response;
@end


@interface ZZWebService : NSObject<NSURLConnectionDelegate>
{
    id <ZZWebCallbackDelegate> delegate;
}

@property (retain) id delegate;

- (void)upload:(NSDictionary*)command;


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse;

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end

