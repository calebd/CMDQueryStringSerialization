//
//  CMDQueryStringSerialization.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringSerialization.h"
#import "CMDQueryStringWriter.h"
#import "CMDQueryStringReader.h"

@implementation CMDQueryStringSerialization

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string {
    CMDQueryStringReader *reader = [[CMDQueryStringReader alloc] initWithString:string];
    return [reader dictionaryValue];
}


+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary {
    CMDQueryStringWritingOptions options = (
                                            CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets |
                                            CMDQueryStringWritingOptionDateAsUnixTimestamp
                                            );
    return [self queryStringWithDictionary:dictionary options:options];
}


+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary options:(CMDQueryStringWritingOptions)options {
    CMDQueryStringWriter *writer = [[CMDQueryStringWriter alloc] initWithDictionary:dictionary options:options];
    return [writer stringValue];
}

@end
