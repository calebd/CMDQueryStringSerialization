//
//  CMDQueryStringWriter.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringWriter.h"
#import "CMDQueryStringValueTransformer.h"

@implementation CMDQueryStringWriter {
    NSDictionary *_dictionary;
    CMDQueryStringWritingOptions _options;
}

#pragma mark - Public

- (instancetype)initWithDictionary:(NSDictionary *)dictionary options:(CMDQueryStringWritingOptions)options {
    if ((self = [super init])) {
        _dictionary = [dictionary copy];
        _options = options;
    }
    return self;
}


- (NSString *)stringValue {
    return [_dictionary CMDQueryStringValueTransformer_queryStringWithKey:nil options:_options];
}

@end
