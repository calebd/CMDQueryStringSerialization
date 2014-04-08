//
//  CMDQueryStringValueTransformer.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringValueTransformer.h"
#import "CMDQueryStringStringTransformer.h"
#import "CMDQueryStringNumberTransformer.h"
#import "CMDQueryStringDateTransformer.h"
#import "CMDQueryStringArrayTransformer.h"

@import ObjectiveC.runtime;

@implementation CMDQueryStringValueTransformer

#pragma mark - CMDQueryStringValueTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value options:(CMDQueryStringWritingOptions)options {
    Class transformerClass = Nil;
    
    if ([value isKindOfClass:[NSString class]]) {
        transformerClass = [CMDQueryStringStringTransformer class];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        transformerClass = [CMDQueryStringNumberTransformer class];
    }
    else if ([value isKindOfClass:[NSArray class]]) {
        transformerClass = [CMDQueryStringArrayTransformer class];
    }
    else if ([value isKindOfClass:[NSDate class]]) {
        transformerClass = [CMDQueryStringDateTransformer class];
    }
    
    if (!transformerClass) {
        [NSException raise:NSInvalidArgumentException format:@"No class is configured to handle %@ objects.", [value class]];
    }
    NSParameterAssert(class_conformsToProtocol(transformerClass, @protocol(CMDQueryStringValueTransformer)));
    id returnValue = [transformerClass stringWithKey:key value:value options:options];
    if (!returnValue) {
        [NSException raise:NSInvalidArgumentException format:nil];
    }
    return returnValue;
}

@end
