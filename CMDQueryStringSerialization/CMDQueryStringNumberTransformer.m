//
//  CMDQueryStringNumberTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 4/5/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringNumberTransformer.h"

@implementation CMDQueryStringNumberTransformer

#pragma mark - CMDQueryStringValueTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value options:(CMDQueryStringWritingOptions)options {
    NSString *escapedKey = [key cmd_stringByAddingEscapes];
    NSString *escapedValue = [[value stringValue] cmd_stringByAddingEscapes];
    return [NSString stringWithFormat:@"%@=%@", escapedKey, escapedValue];
}

@end
