//
//  CMDQueryStringMultipleKeysArrayTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringMultipleKeysArrayTransformer.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringMultipleKeysArrayTransformer

#pragma mark - CMDQueryStringArrayTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value {
    NSMutableArray *pairs = [[NSMutableArray alloc] init];
    
    [value enumerateObjectsUsingBlock:^(NSString *value, NSUInteger index, BOOL *stop) {
        NSString *escapedKey = [key cmd_stringByAddingEscapes];
        NSString *escapedValue = [value cmd_stringByAddingEscapes];
        NSString *string = [NSString stringWithFormat:@"%@=%@", escapedKey, escapedValue];
        [pairs addObject:string];
    }];
    
    return [pairs componentsJoinedByString:@"&"];
}

@end
