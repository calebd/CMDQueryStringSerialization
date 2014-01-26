//
//  CMDKeyValuePairString.m
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDKeyValuePairString.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDKeyValuePairString

+ (NSString *)pairStringWithKey:(NSString *)key value:(NSString *)value {
    return [NSString stringWithFormat:@"%@=%@", key, value];
}

+ (void)enumeratePairsInString:(NSString *)string block:(void (^) (NSString *key, NSString *value))block {
    NSArray *pairs = [string componentsSeparatedByString:@"&"];
    
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
        
        if (block) {
            block(key, value);
        }
    }];
}

@end
