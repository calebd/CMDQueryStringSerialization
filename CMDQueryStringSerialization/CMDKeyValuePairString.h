//
//  CMDKeyValuePairString.h
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

/**
 Convenience methods for creating and extracting key/value pair strings.
 */
@interface CMDKeyValuePairString : NSObject

/**
 Creates a key/value pair string.
 
 @param key Key to use in the key/value pair
 @param value Value to use in the key/value pair
 */
+ (NSString *)pairStringWithKey:(NSString *)key value:(NSString *)value;

/**
 Enumerates key/value pairs in the provided query string.
 
 @param string Query string to extract key/value pairs from
 @param block Block to be called with the key and value for each pair found
 */
+ (void)enumeratePairsInString:(NSString *)string block:(void (^) (NSString *key, NSString *value))block;

@end
