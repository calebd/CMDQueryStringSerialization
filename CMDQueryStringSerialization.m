//
//  CMDQueryStringSerialization.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringSerialization.h"

@interface NSString (CMDQeuryStringSerialization)

- (NSString *)cmd_stringByAddingEscapes;
- (NSString *)cmd_stringByRemovingEscapes;

@end

@implementation CMDQueryStringSerialization

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string {
    if (!string) {
        return nil;
    }
    
    NSMutableDictionary *result = [NSMutableDictionary new];
    NSArray *pairs = [string componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        if ([pair length] == 0) {
            continue;
        }
        
        NSRange range = [pair rangeOfString:@"="];
        NSString *key;
        NSString *value;
        
        if (range.location == NSNotFound) {
            key = [pair cmd_stringByRemovingEscapes];
            value = @"";
        } else {
            key = [pair substringToIndex:range.location];
            key = [key cmd_stringByRemovingEscapes];
            
            value = [pair substringFromIndex:(range.location + range.length)];
            value = [value cmd_stringByRemovingEscapes];
        }
        
        if (!key || !value) {
            continue;
        }
        
        id existingValueForKey = result[key];
        
        if (existingValueForKey) {
            result[key] = ^{
                if ([existingValueForKey isKindOfClass:[NSArray class]]) {
                    return [existingValueForKey arrayByAddingObject:value];
                } else {
                    return @[existingValueForKey, value];
                }
            }();
        } else {
            result[key] = value;
        }
    }
    
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

@implementation NSString (CMDQeuryStringSerialization)

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

@end
