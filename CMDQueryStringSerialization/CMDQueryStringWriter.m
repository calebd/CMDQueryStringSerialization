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
#import "CMDQueryStringValueTransformer.h"

@implementation CMDQueryStringWriter {
    NSDictionary *_dictionary;
    CMDQueryStringWritingOptions _options;
}

#pragma mark - Public

- (instancetype)initWithDictionary:(NSDictionary *)dictionary options:(CMDQueryStringWritingOptions)options {
    if ((self = [super init])) {
        _dictionary = [dictionary copy];
        _options = options;
    }
    return self;
}


- (NSString *)stringValue {
    if (!_dictionary) {
        return nil;
    }
    
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
    
    // Trasform the value and return
    return [CMDQueryStringValueTransformer stringWithKey:key value:value options:_options];
}

@end
