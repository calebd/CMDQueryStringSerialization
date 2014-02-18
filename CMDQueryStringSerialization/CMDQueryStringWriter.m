//
//  CMDQueryStringWriter.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringWriter.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringWriter {
    NSMutableDictionary *_dictionary;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (!dictionary) {
        return nil;
    }
    if ((self = [super init])) {
        _dictionary = [dictionary mutableCopy];
    }
    return self;
}


- (NSString *)stringValue {
    NSMutableArray *pairs = [NSMutableArray new];
    [_dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if ([value isKindOfClass:[NSString class]]) {
            value = [value cmd_stringByAddingEscapes];
        }
        else if ([value isKindOfClass:[NSNumber class]]) {
            value = [value stringValue];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            value = [value description];
        }
        else {
            [NSException raise:NSInvalidArgumentException format:nil];
        }
        NSString *pair = [NSString stringWithFormat:@"%@=%@", [key cmd_stringByAddingEscapes], value];
        [pairs addObject:pair];
    }];
    return [pairs componentsJoinedByString:@"&"];
}

@end
