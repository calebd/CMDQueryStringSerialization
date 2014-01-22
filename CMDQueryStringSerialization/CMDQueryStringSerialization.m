//
//  CMDQueryStringSerialization.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringSerialization.h"

@interface NSString (CMDQueryStringSerialization)

- (NSString *)cmd_stringByAddingEscapes;
- (NSString *)cmd_stringByRemovingEscapes;
- (void)cmd_enumeratePairs:(void (^) (NSString *key, NSString *value))block;

@end

@interface NSMutableDictionary (CMDQueryStringSerialization)

- (void)cmd_addObject:(id)object forKey:(NSString *)key;

@end

@implementation CMDQueryStringSerialization

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string {
    if (!string) {
        return nil;
    }
    NSMutableDictionary *result = [NSMutableDictionary new];
    [string cmd_enumeratePairs:^(NSString *key, NSString *value) {
        [result cmd_addObject:value forKey:key];
    }];
    return result;
}


+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary {
    NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:[dictionary count]];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        void (^addPair)(NSString *key, NSString *value) = ^(NSString *key, NSString *value) {
            [pairs addObject:[NSString stringWithFormat:@"%@=%@",
                              [key cmd_stringByAddingEscapes],
                              [value cmd_stringByAddingEscapes]]];
        };
        
        if ([value isKindOfClass:[NSArray class]]) {
            for (NSString *valueFromArray in (NSArray *)value) {
                addPair(key, valueFromArray);
            }
        } else {
            addPair(key, value);
        }
    }];
    return [pairs componentsJoinedByString:@"&"];
}

@end

@implementation NSString (CMDQueryStringSerialization)

- (NSString *)cmd_stringByAddingEscapes {
    CFStringRef string = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                 (CFStringRef)self,
                                                                 NULL,
                                                                 CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    return (NSString *)CFBridgingRelease(string);
}


- (NSString *)cmd_stringByRemovingEscapes {
    return [self stringByRemovingPercentEncoding];
}


- (void)cmd_enumeratePairs:(void (^) (NSString *key, NSString *value))block {
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    [pairs enumerateObjectsUsingBlock:^(NSString *pair, NSUInteger index, BOOL *stop) {
        NSRange range = [pair rangeOfString:@"="];
        NSString *key, *value;
        if (range.location == NSNotFound) {
            key = [pair cmd_stringByRemovingEscapes];
            value = @"";
        }
        else {
            key = [pair substringToIndex:range.location];
            key = [key cmd_stringByRemovingEscapes];
            value = [pair substringFromIndex:(range.location + range.length)];
            value = [value cmd_stringByRemovingEscapes];
        }
        key = [key stringByReplacingOccurrencesOfString:@"[]" withString:@""];
        block(key, value);
    }];
}

@end

@implementation NSMutableDictionary (CMDQueryStringSerialization)

- (void)cmd_addObject:(id)object forKey:(NSString *)key {
    id existingObject = self[key];
    if (existingObject) {
        if ([existingObject isKindOfClass:[NSArray class]]) {
            self[key] = [existingObject arrayByAddingObject:object];
        }
        else {
            self[key] = @[ existingObject, object ];
        }
    }
    else {
        self[key] = object;
    }
}

@end
