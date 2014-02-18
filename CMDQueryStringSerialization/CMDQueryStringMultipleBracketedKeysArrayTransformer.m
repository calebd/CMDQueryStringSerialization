//
//  CMDQueryStringMultipleBracketedKeysArrayTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDKeyValuePairString.h"
#import "CMDQueryStringMultipleBracketedKeysArrayTransformer.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringMultipleBracketedKeysArrayTransformer

#pragma mark - CMDQueryStringArrayTransformer

+ (NSArray *)keyValuePairStringsFromKey:(NSString *)key values:(NSArray *)values {
    NSMutableArray *mutablePairs = [[NSMutableArray alloc] init];
    
    [values enumerateObjectsUsingBlock:^(NSString *value, NSUInteger index, BOOL *stop) {
        NSString *escapedKey = [[key cmd_stringByAddingEscapes] stringByAppendingString:@"[]"];
        NSString *escapedValue = [value cmd_stringByAddingEscapes];
        
        [mutablePairs addObject:[CMDKeyValuePairString pairStringWithKey:escapedKey value:escapedValue]];
    }];
    
    return [mutablePairs copy];
}

@end
