//
//  CMDQueryStringDateTransformer.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 4/5/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringDateTransformer.h"

@implementation CMDQueryStringDateTransformer

#pragma mark - CMDQueryStringValueTransformer

+ (NSString *)stringWithKey:(NSString *)key value:(id)value options:(CMDQueryStringWritingOptions)options {
    if ((options & CMDQueryStringWritingOptionDateAsUnixTimestamp) == CMDQueryStringWritingOptionDateAsUnixTimestamp) {
        NSNumber *number = @((NSInteger)[value timeIntervalSince1970]);
        return [CMDQueryStringValueTransformer stringWithKey:key value:number options:options];
    }
    return nil;
}

@end
