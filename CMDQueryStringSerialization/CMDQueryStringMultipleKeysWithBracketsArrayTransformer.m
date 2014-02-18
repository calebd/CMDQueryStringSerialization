//
//  CMDQueryStringMultipleBracketedKeysArrayTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringMultipleKeysWithBracketsArrayTransformer.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringMultipleKeysWithBracketsArrayTransformer

#pragma mark - CMDQueryStringArrayTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value {
    NSMutableArray *mutablePairs = [[NSMutableArray alloc] init];
    
    [value enumerateObjectsUsingBlock:^(NSString *value, NSUInteger index, BOOL *stop) {
        NSString *escapedKey = [[key cmd_stringByAddingEscapes] stringByAppendingString:@"[]"];
        NSString *escapedValue = [value cmd_stringByAddingEscapes];
        NSString *string = [NSString stringWithFormat:@"%@=%@", escapedKey, escapedValue];
        [mutablePairs addObject:string];
    }];
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

@end
