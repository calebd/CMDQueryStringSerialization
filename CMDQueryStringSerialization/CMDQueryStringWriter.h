//
//  CMDQueryStringWriter.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

@interface CMDQueryStringWriter : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)stringValue;

@end
