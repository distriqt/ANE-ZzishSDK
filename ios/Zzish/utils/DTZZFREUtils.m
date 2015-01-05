//
//  DTZZFREUtils.m
//  Zzish
//
//  Created by Michael Archbold on 27/08/13.
//  Copyright (c) 2013 distriqt. All rights reserved.
//

#import "DTZZFREUtils.h"

#import <UIKit/UIKit.h>

@implementation DTZZFREUtils

#define DEBUG true
#define PRINT_LOG true

#define EVENT_LOG false
#define EVENT_LOG_CODE  @"log"


NSString const * DTZZTAG = @"com.distriqt.EXT";

//
//  Controlled log function
//  eg.
//      [FREUtils log: context message: @"something interesting happened"];
//

+(void)debug: (NSString*) message
{
#if DEBUG
    [DTZZFREUtils log: nil message: [NSString stringWithFormat: @"DEBUG::%@", message]];
#endif
}


+(void) log: (NSString*) message, ...
{
    va_list args;
    va_start(args, message);
    NSString* formatedMessage = [[NSString alloc] initWithFormat: message arguments: args];
    va_end(args);
    
    [DTZZFREUtils log: nil message: formatedMessage ];
}


+(void)log: (FREContext) context message: (NSString*) message
{
#if PRINT_LOG
    NSLog( @"%@::%@", DTZZTAG, message );
#endif
#if EVENT_LOG
    if (context != nil)
        [DTZZFREUtils dispatchStatusEvent: context code: EVENT_LOG_CODE level: message];
#endif
}


+(void) setLogTag: (NSString*) tag
{
    DTZZTAG = [tag copy];
}


//
//  Event dispatch
//

+(void) dispatchStatusEvent: (FREContext) context code: (NSString*) code level: (NSString*) level
{
    if (context != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            FREDispatchStatusEventAsync( context, (const uint8_t*)[code UTF8String], (const uint8_t*)[level UTF8String]);
        });
    }
}


#pragma mark - FREObject HELPERS

//
//  FREObject HELPERS
//

+(NSString*) getFREObjectAsString: (FREObject) object
{
    uint32_t length;
    const uint8_t *value;
    
    if (FRE_OK == FREGetObjectAsUTF8( object, &length, &value))
    {
        NSString* objectString = [NSString stringWithUTF8String:(char*)value];
        return objectString;
    }
    
    return @"";
}


+(int) getFREObjectAsInt: (FREObject) object
{
    int32_t value;
    if (FRE_OK == FREGetObjectAsInt32( object, &value))
    {
        return value;
    }
    return 0;
}


+(Boolean) getFREObjectAsBoolean: (FREObject) object
{
    uint32_t value;
    if (FRE_OK == FREGetObjectAsBool( object, &value ))
    {
        return (value == 1);
    }
    return false;
}


+(NSData*) getFREObjectAsNSData: (FREObject) object
{
    NSData* nsData = nil;
    FREByteArray byteArray;
    if ((object != NULL) && (FRE_OK == FREAcquireByteArray( object, &byteArray )))
    {
        int length = byteArray.length;
        nsData = [NSData dataWithBytes: byteArray.bytes
                                length: length ];
        FREReleaseByteArray( object );
    }
    else
    {
        nsData = [[NSData alloc] init];
    }
    return nsData;
}


//
//  Array conversions
//

+(NSArray*) getFREObjectAsArrayOfStrings: (FREObject) source
{
    [DTZZFREUtils log: @"GetObjectAsArrayOfStrings"];
    
    uint32_t length = 0;
    FREGetArrayLength( source, &length );
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (uint32_t i = 0; i < length; i++)
    {
        FREObject element;
        FREGetArrayElementAt( source, i, &element );
        
        NSString* string = [DTZZFREUtils getFREObjectAsString: element];
        
        [DTZZFREUtils log: [NSString stringWithFormat:@"addObject: %@", string] ];
        
        [array addObject: string];
    }
    
    return array;
}


+(NSArray*) getFREObjectAsArrayOfNumbers: (FREObject) source
{
    [DTZZFREUtils log: @"GetObjectAsArrayOfInts"];
    
    uint32_t length = 0;
    FREGetArrayLength( source, &length );
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (uint32_t i = 0; i < length; i++)
    {
        FREObject element;
        FREGetArrayElementAt( source, i, &element );
        
        int value = 0;
        FREGetObjectAsInt32( element, &value );
        
        [DTZZFREUtils log: [NSString stringWithFormat:@"addObject: %d", value] ];
        
        [array addObject: [NSNumber numberWithInt: value]];
    }
    
    return array;
}


+(FREObject) newFREArrayFromStringArray: (NSArray*)array
{
    FREObject fa;
    FRENewObject((const uint8_t*)"Array", 0, NULL, &fa, nil);
    
    FRESetArrayLength( fa, (uint32_t)[array count] );
    
    for (int i = 0; i < [array count]; i++)
    {
        NSString* string = [array objectAtIndex: i];
        FREObject fs;
        FRENewObjectFromUTF8( (uint32_t)[string length], (const uint8_t*)[string UTF8String], &fs );
        FRESetArrayElementAt( fa, i, fs );
    }
    
    return fa;
}


//
//  Dictionary Key/Value Conversions
//

+(NSDictionary*) keyValueStringFREArraysToNSDictionary: (FREObject) keys values: (FREObject) values
{
    uint32_t numKeys, numValues;
    if (FRE_OK != FREGetArrayLength( keys, &numKeys )) return nil;
    if (FRE_OK != FREGetArrayLength( keys, &numValues )) return nil;
    
    if (numKeys != numValues) return nil;
    
    NSArray* keysArray   = [DTZZFREUtils getFREObjectAsArrayOfStrings: keys];
    NSArray* valuesArray = [DTZZFREUtils getFREObjectAsArrayOfStrings: values];
    
    return [DTZZFREUtils keyValueArraysToNSDictionary: keysArray values: valuesArray];
}


+(NSDictionary*) keyValueArraysToNSDictionary: (NSArray*) keys values: (NSArray*) values
{
    if ([keys count] != [values count]) return nil;
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [keys count]; ++i)
    {
        [DTZZFREUtils log: [NSString stringWithFormat: @"key: %@ value: %@", [keys objectAtIndex: i], [values objectAtIndex: i] ]];
        [dict setObject: [values objectAtIndex:i]
                 forKey: [keys objectAtIndex: i]];
    }
    
    return dict;
}


//
//  Object property access
//

+(NSString*) getFREObjectPropertyAsString: (NSString*) property
                                   object: (FREObject) object
{
    FREObject propertyObject;
    if (object != NULL &&
        FRE_OK == FREGetObjectProperty( object, (const uint8_t*)[property UTF8String], &propertyObject, NULL ))
    {
        uint32_t length;
        const uint8_t *value;
        if (propertyObject != NULL &&
            FRE_OK == FREGetObjectAsUTF8( propertyObject, &length, &value))
        {
            return [NSString stringWithUTF8String:(const char*)value];
        }
    }
    [DTZZFREUtils log: @"FREUtils::ERROR!!" ];
    return @"";
}


+(Boolean) getFREObjectPropertyAsBoolean: (NSString*) property
                                  object: (FREObject) object
{
    FREObject propertyObject;
    FREGetObjectProperty( object, (const uint8_t*)[property UTF8String], &propertyObject, NULL );
    
    uint32_t value;
    if (FRE_OK != FREGetObjectAsBool( propertyObject, &value ))
    {
        [DTZZFREUtils log: @"FREUtils::ERROR!!" ];
        return false;
    }
    
    return (value == 1);
}


+(int32_t) getFREObjectPropertyAsInt: (NSString*) property
                              object: (FREObject) object
{
    FREObject propertyObject;
    FREGetObjectProperty( object, (const uint8_t*)[property UTF8String], &propertyObject, NULL );
    
    int32_t value;
    if (FRE_OK != FREGetObjectAsInt32( propertyObject, &value ))
    {
        [DTZZFREUtils log: @"FREUtils::ERROR!!" ];
        return 0;
    }
    
    return value;
}


+(double) getFREObjectPropertyAsDouble: (NSString*) property
                                object: (FREObject) object
{
    FREObject propertyObject;
    FREGetObjectProperty( object, (const uint8_t*)[property UTF8String], &propertyObject, NULL );
    
    double value = 0.0;
    if (FRE_OK != FREGetObjectAsDouble( propertyObject, &value ))
    {
        [DTZZFREUtils log: @"FREUtils::ERROR!!" ];
        return 0.0;
    }
    return value;
}


+(FREObject) getFREObjectPropertyAsObject: (NSString*) property
                                   object: (FREObject) object
{
    FREObject propertyObject;
    if (FRE_OK == FREGetObjectProperty( object, (const uint8_t*)[property UTF8String], &propertyObject, NULL ))
    {
        return propertyObject;
    }
    return NULL;
}




//
//  NEW OBJECTS
//



+(FREObject) newFREObjectFromString: (NSString*) value
{
    FREObject result = NULL;
    if (value != nil)
    {
        FRENewObjectFromUTF8( (uint32_t)strlen((const char*)[value UTF8String]) + 1, (const uint8_t*)[value UTF8String], &result);
    }
    else
    {
        FRENewObjectFromUTF8( (uint32_t)strlen((const char*)[@"" UTF8String]) + 1, (const uint8_t*)[@"" UTF8String], &result);
    }
    return result;
}


+(FREObject) newFREObjectFromInt: (int) value
{
    FREObject result = NULL;
    FRENewObjectFromInt32( value, &result );
    return result;
}


+(FREObject) newFREObjectFromLong: (long) value
{
    FREObject result = NULL;
    FRENewObjectFromInt32( (int)value, &result );
    return result;
}


+(FREObject) newFREObjectFromBoolean: (Boolean) value
{
    FREObject result = NULL;
    FRENewObjectFromBool( value, &result );
    return result;
}


+(FREObject) newFREObjectFromDouble: (double) value
{
    FREObject result = NULL;
    FRENewObjectFromDouble( value, &result );
    return result;
}


+(FREObject) newFREObjectFromNSUInteger: (NSUInteger) integerValue
{
    FREObject result = NULL;
    FRENewObjectFromUint32( (uint)integerValue, &result );
    return result;
}


+(FREObject) newFREObjectFromNSInteger: (NSInteger) integerValue
{
    FREObject result = NULL;
    FRENewObjectFromInt32( (int)integerValue, &result );
    return result;
}


+(FREObject) newFREObjectFromNSNumber: (NSNumber*) value
{
    if ((0 == strcmp( [value objCType], @encode(Boolean)))
        ||
        (0 == strcmp( [value objCType], @encode(BOOL))))
    {
        return [DTZZFREUtils newFREObjectFromNSInteger: ([value boolValue] == YES)];
    }
    
    else if (0 == strcmp( [value objCType], @encode(int)))
    {
        return [DTZZFREUtils newFREObjectFromNSInteger: [value integerValue]];
    }
    
    else if (0 == strcmp( [value objCType], @encode(uint)))
    {
        return [DTZZFREUtils newFREObjectFromNSUInteger: [value unsignedIntegerValue]];
    }
    
    else //if (0 == strcmp( [value objCType], @encode(double)))
    {
        return [DTZZFREUtils newFREObjectFromDouble: [value doubleValue] ];
        
    }
    
    return NULL;
}


+(FREObject) newFREObjectFromNSData: (NSData*) data
{
    FREObject result = NULL;
    if (FRE_OK == FRENewObject((const uint8_t*)"flash.utils.ByteArray", 0, NULL, &result, NULL ))
    {
        [DTZZFREUtils setFREObjectProperty: @"length"
                                    object: result
                                     value: [DTZZFREUtils newFREObjectFromInt: (int)data.length]];
        
        FREByteArray byteArray;
        if (FRE_OK == FREAcquireByteArray( result, &byteArray ))
        {
            memcpy( byteArray.bytes, data.bytes, data.length );
            FREReleaseByteArray( result );
        }
    }
    return result;
}


+(FREObject) newFREObject
{
    FREObject result = NULL;
    FRENewObject( (const uint8_t*)"Object", 0, NULL, &result, NULL);
    return result;
}


+(FREResult) setFREObjectProperty: (NSString*) property object: (FREObject) object value: (FREObject) value
{
    if (property == nil || object == NULL || value == NULL)
        return FRE_INVALID_ARGUMENT;
    return FRESetObjectProperty( object, (const uint8_t*)[property UTF8String], value, NULL );
}









#pragma mark - VIEW HELPERS

//
//  VIEW (CONTROLLER) HELPERS
//


+(UIViewController*) getRootViewController
{
    return [[[UIApplication sharedApplication] keyWindow] rootViewController];
}



#pragma mark - BITMAP HELPERS

//
//  BITMAP HELPERS
//


+(Boolean) drawUIImageToBitmapData: (UIImage*) image bitmapData: (FREBitmapData*) bitmapData
{
    [DTZZFREUtils log: [NSString stringWithFormat: @"drawUIImageToBitmapData (%d x %d)", bitmapData->width, bitmapData->height]];
    
    //
    // Pull the raw pixels values out of the image data
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width  = CGImageGetWidth( imageRef );
    NSUInteger height = CGImageGetHeight( imageRef );
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    //
    // Pixels are now it rawData in the format RGBA8888
    // So we convert and write them into the BitmapData
    int x, y;
    int offset = bitmapData->lineStride32 - bitmapData->width;
    int offset2 = (uint)bytesPerRow - bitmapData->width*4;
    int byteIndex = 0;
    uint32_t *bitmapDataPixels = bitmapData->bits32;
    for (y=0; y<bitmapData->height; y++)
    {
        for (x=0; x<bitmapData->width; x++, bitmapDataPixels++, byteIndex += 4)
        {
            // Values are currently in RGBA7777, so each color value is currently a separate number.
            int red     = (rawData[byteIndex]);
            int green   = (rawData[byteIndex + 1]);
            int blue    = (rawData[byteIndex + 2]);
            int alpha   = (rawData[byteIndex + 3]);
            
            // Combine values into ARGB32
            *bitmapDataPixels = (alpha << 24) | (red << 16) | (green << 8) | blue;
        }
        
        bitmapDataPixels += offset;
        byteIndex += offset2;
    }
    
    // Free the memory we allocated
    free(rawData);
    
    return true;
}


+(Boolean) drawCGImageRefToBitmapData: (CGImageRef) imageRef bitmapData: (FREBitmapData*) bitmapData
{
    NSUInteger width  = CGImageGetWidth ( imageRef );
    NSUInteger height = CGImageGetHeight( imageRef );
    
    [DTZZFREUtils log: [NSString stringWithFormat: @"drawCGImageRefToBitmapData: BitmapData: (%d x %d) CGImage: (%d x %d)", bitmapData->width, bitmapData->height, (uint)width, (uint)height]];
    
    if (width != bitmapData->width || height != bitmapData->height)
    {
        return false;
    }
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    //
    // Pixels are now it rawData in the format RGBA8888
    // So we convert and write them into the BitmapData
    int x, y;
    int offset = bitmapData->lineStride32 - bitmapData->width;
    int offset2 = (uint)bytesPerRow - bitmapData->width*4;
    int byteIndex = 0;
    uint32_t *bitmapDataPixels = bitmapData->bits32;
    for (y=0; y<bitmapData->height; y++)
    {
        for (x=0; x<bitmapData->width; x++, bitmapDataPixels++, byteIndex += 4)
        {
            // Values are currently in RGBA7777, so each color value is currently a separate number.
            int red     = (rawData[byteIndex]);
            int green   = (rawData[byteIndex + 1]);
            int blue    = (rawData[byteIndex + 2]);
            int alpha   = (rawData[byteIndex + 3]);
            
            // Combine values into ARGB32
            *bitmapDataPixels = (alpha << 24) | (red << 16) | (green << 8) | blue;
        }
        
        bitmapDataPixels += offset;
        byteIndex += offset2;
    }
    
    // Free the memory we allocated
    free(rawData);
    
    [DTZZFREUtils log: @"drawCGImageRefToBitmapData: complete" ];
    
    return true;
    
}


+(UIImage*) createUIImageFromBitmapData: (FREBitmapData*) bitmapData
{
    [DTZZFREUtils log: @"createUIImageFromBitmapData" ];
    
    int width       = bitmapData->width;
    int height      = bitmapData->height;
    
    [DTZZFREUtils log: [NSString stringWithFormat: @"width=%d height=%d", width, height]];
    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData->bits32, (width * height * 4), NULL);
    
    //
    // set up for CGImage creation
    int                     bitsPerComponent    = 8;
    int                     bitsPerPixel        = 32;
    int                     bytesPerRow         = 4 * bitmapData->lineStride32;
    CGColorSpaceRef         colorSpaceRef       = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo            bitmapInfo;
    
    if ( bitmapData->hasAlpha )
    {
        if ( bitmapData->isPremultiplied )
            bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst;
        else
            bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaFirst;
    }
    else
    {
        bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
    }
    
    CGColorRenderingIntent  renderingIntent     = kCGRenderingIntentDefault;
    CGImageRef              imageRef            = CGImageCreate( width,
                                                                height,
                                                                bitsPerComponent,
                                                                bitsPerPixel,
                                                                bytesPerRow,
                                                                colorSpaceRef,
                                                                bitmapInfo,
                                                                provider,
                                                                NULL,
                                                                NO,
                                                                renderingIntent );
    
    //
    // make UIImage from CGImage
    UIImage *image      = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    
    return image;
}



//
//  BASE 64
//

+(NSData*) initDataWithString: (NSString*) source
{
    if ([[NSData alloc] respondsToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        return [[NSData alloc] initWithBase64EncodedString: source options:0 ];
    }
    else
    {
        return [[NSData alloc] initWithBase64Encoding: source];
    }
}


@end



