//
//  CMDQueryStringArrayTransformer.h
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

/**
 Defines an interface for transforming a key and array of values into an array
 of query string key/value pairs.
 */
@protocol CMDQueryStringArrayTransformer <NSObject>

/**
 Generates key/value pair strings from a key and array of values
 
 @param key Key to be included in the key/value pair string(s)
 @param value Value to be included in the key/value pair string(s)
 @return One or more key/value pair string
 */
+ (NSArray *)keyValuePairStringsFromKey:(NSString *)key values:(NSArray *)values;

@end
