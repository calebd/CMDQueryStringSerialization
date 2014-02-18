//
//  CMDQueryStringReader.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringReader.h"
#import "NSString+CMDQueryStringSerialization.h"

@implementation CMDQueryStringReader {
    NSMutableDictionary *_dictionary;
}

#pragma mark - Public

- (instancetype)initWithString:(NSString *)string {
    if (!string) {
        return nil;
    }
    if ((self = [super init])) {
        _dictionary = [NSMutableDictionary new];
        [[self class] enumeratePairsInString:string block:^(NSString *key, NSString *value) {
            _dictionary[key] = value;
        }];
    }
    return self;
}


- (NSDictionary *)dictionaryValue {
    return [_dictionary copy];
}


#pragma mark - Private

+ (void)enumeratePairsInString:(NSString *)string block:(void (^) (NSString *key, NSString *value))block {
    NSArray *pairs = [string componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSRange range = [pair rangeOfString:@"="];
        NSString *key, *value;
        if (range.location == NSNotFound) {
            key = [pair cmd_stringByRemovingEscapes];
        }
        else {
            key = [pair substringToIndex:range.location];
            key = [key cmd_stringByRemovingEscapes];
            value = [pair substringFromIndex:(range.location + range.length)];
            value = [value cmd_stringByRemovingEscapes];
        }
        block(key ?: @"", value ?: @"");
    }
}

@end
