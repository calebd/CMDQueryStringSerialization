//
//  CMDQueryStringWriter.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringWriter.h"
#import "NSString+CMDQueryStringSerialization.h"
#import "CMDQueryStringSerialization.h"
#import "CMDQueryStringCommaSeparatedArrayTransformer.h"
#import "CMDQueryStringMultipleKeysArrayTransformer.h"
#import "CMDQueryStringMultipleKeysWithBracketsArrayTransformer.h"

@implementation CMDQueryStringWriter {
    NSMutableDictionary *_dictionary;
    CMDQueryStringWritingOptions _options;
}

#pragma mark - Public

- (instancetype)initWithDictionary:(NSDictionary *)dictionary options:(CMDQueryStringWritingOptions)options {
    if (!dictionary) {
        return nil;
    }
    if ((self = [super init])) {
        _dictionary = [dictionary mutableCopy];
        _options = options;
    }
    return self;
}


- (NSString *)stringValue {
    NSMutableArray *pairs = [NSMutableArray new];
    [_dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *string = [self stringWithKey:key value:value];
        [pairs addObject:string];
    }];
    return [pairs componentsJoinedByString:@"&"];
}


#pragma mark - Private

- (NSString *)stringWithKey:(id)key value:(id)value {
    
    // Be sure the key is a string
    if (![key isKindOfClass:[NSString class]]) {
        [NSException raise:NSInvalidArgumentException format:nil];
    }
    key = [key cmd_stringByAddingEscapes];
    
    // Escape strings
    if ([value isKindOfClass:[NSString class]]) {
        value = [value cmd_stringByAddingEscapes];
    }
    
    // Convert numbers into strings
    else if ([value isKindOfClass:[NSNumber class]]) {
        value = [value stringValue];
    }
    
    // Transform arrays
    else if ([value isKindOfClass:[NSArray class]]) {
        if ((_options & CMDQueryStringWritingOptionArrayCommaSeparatedValues) == CMDQueryStringWritingOptionArrayCommaSeparatedValues) {
            value = [CMDQueryStringCommaSeparatedArrayTransformer stringWithKey:key value:value];
        }
        else if ((_options & CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets) == CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets) {
            value = [CMDQueryStringMultipleKeysWithBracketsArrayTransformer stringWithKey:key value:value];
        }
        else if ((_options & CMDQueryStringWritingOptionArrayRepeatKeys) == CMDQueryStringWritingOptionArrayRepeatKeys) {
            value = [CMDQueryStringMultipleKeysArrayTransformer stringWithKey:key value:value];
        }
        return value;
    }
    
    // Bail out
    else {
        [NSException raise:NSInvalidArgumentException format:nil];
    }
    
    // Flatten
    return [NSString stringWithFormat:@"%@=%@", key, value];
}

@end
