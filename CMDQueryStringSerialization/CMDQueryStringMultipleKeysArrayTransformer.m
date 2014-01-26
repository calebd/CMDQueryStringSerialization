//
//  CMDQueryStringMultipleKeysArrayTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDKeyValuePairString.h"
#import "CMDQueryStringMultipleKeysArrayTransformer.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringMultipleKeysArrayTransformer

#pragma mark - CMDQueryStringArrayTransformer

+ (NSArray *)keyValuePairStringsFromKey:(NSString *)key values:(NSArray *)values {
    NSMutableArray *mutablePairs = [[NSMutableArray alloc] init];
    
    [values enumerateObjectsUsingBlock:^(NSString *value, NSUInteger index, BOOL *stop) {
        NSString *escapedKey = [key cmd_stringByAddingEscapes];
        NSString *escapedValue = [value cmd_stringByAddingEscapes];
        
        [mutablePairs addObject:[CMDKeyValuePairString pairStringWithKey:escapedKey value:escapedValue]];
    }];
    
    return [mutablePairs copy];
}

@end
