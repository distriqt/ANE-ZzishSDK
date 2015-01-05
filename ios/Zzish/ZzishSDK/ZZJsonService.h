//
//  ZZJsonService.h
//  Pods
//
//  Created by Samir Seetal on 17/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZFileService.h"

#define ENDPOINT_PARAM @"endpoint"
#define DATA_PARAM @"data"

@interface ZZJsonService : ZZFileService

/*!
 * @discussion Returns the next JSON Dictionary (with data and endpoint) to submit to web service. nil if there is nothing
 * @return returns nil if nothing exists or a JSON Dictionary (with data and endpoint)
 */
+ (NSDictionary *)next;

/*!
 * @discussion Saves a JSON Dictionary (with data and endpoint) at the end of the list
 * @param json the JSON Dictionary (with data and endpoint) to save
 */
+ (NSDictionary *)saveRequest:(NSDictionary *)json andReturn:(BOOL)returnFirst;

/*!
 * @discussion Inserts a JSON Dictionary (with data and endpoint) at the begnning
 * @param json the JSON JSON Dictionary (with data and endpoint) to save
 */
+ (void)buffer:(NSDictionary *)json;


@end
