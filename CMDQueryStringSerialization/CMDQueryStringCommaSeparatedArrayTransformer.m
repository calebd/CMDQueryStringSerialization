//
//  CMDQueryStringCommaSeparatedArrayTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDKeyValuePairString.h"
#import "CMDQueryStringCommaSeparatedArrayTransformer.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringCommaSeparatedArrayTransformer

#pragma mark - CMDQueryStringArrayTransformer

+ (NSArray *)keyValuePairStringsFromKey:(NSString *)key values:(NSArray *)values {
    NSMutableArray *escapedValues = [NSMutableArray arrayWithCapacity:[values count]];
    
    [values enumerateObjectsUsingBlock:^(NSString *value, NSUInteger index, BOOL *stop) {
        [escapedValues addObject:[value cmd_stringByAddingEscapes]];
    }];
    
    return @[[CMDKeyValuePairString pairStringWithKey:[key cmd_stringByAddingEscapes]
                                                value:[escapedValues componentsJoinedByString:@","]]];
}

@end
