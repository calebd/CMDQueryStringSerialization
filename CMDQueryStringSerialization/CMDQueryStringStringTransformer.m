//
//  CMDQueryStringStringTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 4/5/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringStringTransformer.h"

@implementation CMDQueryStringStringTransformer

#pragma mark - CMDQueryStringValueTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value options:(CMDQueryStringWritingOptions)options {
    return [NSString stringWithFormat:@"%@=%@",
            [key cmd_stringByAddingEscapes],
            [value cmd_stringByAddingEscapes]];
}

@end
