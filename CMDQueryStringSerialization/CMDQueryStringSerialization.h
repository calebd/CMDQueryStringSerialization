//
//  CMDQueryStringSerialization.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, CMDQueryStringWritingOptions) {
    
    // Default: Arrays encoded with format: `key=value1&key=value2`
    CMDQueryStringWritingOptionArrayRepeatKeys = 1 << 4,
    
    // Arrays encoded with format: `key[]=value1&key[]=value2`
    CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets = 2 << 4,
    
    // Arrays encoded with format: `key=value1,value2`
    CMDQueryStringWritingOptionArrayCommaSeparatedValues = 3 << 4
};

/**
 Easily convert between query strings and dictionaries.
 */
@interface CMDQueryStringSerialization : NSObject

/**
 Deserialize a query string into a dictionary. Calling this method is equivalent to calling `dictionaryWithQueryString:arrayOption:` and passing `CMDQueryStringArraySerializationOptionMultipleKeys`.
 
 @param string Query string to be deserialized
 @param options Serialization options
 
 @return A dictionary.
 */
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string;

/**
 This method is deprecated. Call `queryStringWithDictionary:options:` instead.
 */
+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary;

/**
 Serialize a dictionary into a query string.
 
 @param dictionary Dictionary to be serialized
 @param options Serialization options
 
 @return A query string.
 */
+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary options:(CMDQueryStringWritingOptions)options;

@end

