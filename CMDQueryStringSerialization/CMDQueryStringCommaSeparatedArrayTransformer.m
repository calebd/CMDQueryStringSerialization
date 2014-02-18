//
//  CMDQueryStringCommaSeparatedArrayTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringCommaSeparatedArrayTransformer.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringCommaSeparatedArrayTransformer

#pragma mark - CMDQueryStringArrayTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value {
    NSMutableArray *escapedValues = [NSMutableArray arrayWithCapacity:[value count]];
    
    [value enumerateObjectsUsingBlock:^(NSString *value, NSUInteger index, BOOL *stop) {
        [escapedValues addObject:[value cmd_stringByAddingEscapes]];
    }];
    
    key = [key cmd_stringByAddingEscapes];
    value = [escapedValues componentsJoinedByString:@","];
    return [NSString stringWithFormat:@"%@=%@", key, value];
}

@end
