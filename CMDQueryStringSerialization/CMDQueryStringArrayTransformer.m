//
//  CMDQueryStringArrayTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 4/5/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringArrayTransformer.h"

@implementation CMDQueryStringArrayTransformer

#pragma mark - CMDQueryStringValueTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value options:(CMDQueryStringWritingOptions)options {
    NSArray *escapedValues = [value valueForKey:@"cmd_stringByAddingEscapes"];
    if ((options & CMDQueryStringWritingOptionArrayCommaSeparatedValues) == CMDQueryStringWritingOptionArrayCommaSeparatedValues) {
        key = [key cmd_stringByAddingEscapes];
        value = [escapedValues componentsJoinedByString:@","];
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    else if ((options & CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets) == CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets) {
        NSMutableArray *pairs = [NSMutableArray new];
        for (id escapedValue in escapedValues) {
            NSString *string = [NSString stringWithFormat:@"%@[]=%@", [key cmd_stringByAddingEscapes], escapedValue];
            [pairs addObject:string];
        }
        return [pairs componentsJoinedByString:@"&"];
    }
    else if ((options & CMDQueryStringWritingOptionArrayRepeatKeys) == CMDQueryStringWritingOptionArrayRepeatKeys) {
        NSMutableArray *pairs = [NSMutableArray new];
        for (id escapedValue in escapedValues) {
            NSString *string = [NSString stringWithFormat:@"%@=%@", [key cmd_stringByAddingEscapes], escapedValue];
            [pairs addObject:string];
        }
        return [pairs componentsJoinedByString:@"&"];
    }
    return nil;
}

@end
