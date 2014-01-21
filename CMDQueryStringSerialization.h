//
//  CMDQueryStringSerialization.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

@interface CMDQueryStringSerialization : NSObject

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string;
+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary;

@end
