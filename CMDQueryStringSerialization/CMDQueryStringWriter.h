//
//  CMDQueryStringWriter.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringSerialization.h"

@interface CMDQueryStringWriter : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary options:(CMDQueryStringWritingOptions)options;

- (NSString *)stringValue;

@end
