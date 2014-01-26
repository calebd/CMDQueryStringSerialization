//
//  CMDQueryStringSerialization.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

typedef NS_ENUM(NSUInteger, CMDQueryStringArraySerializationOption) {
    CMDQueryStringArraySerializationOptionMultipleKeys,             // Default: Arrays encoded with format: `key=value1&key=value2`
    CMDQueryStringArraySerializationOptionMultipleBracketedKeys,    // Arrays encoded with format: `key[]=value1&key[]=value2`
    CMDQueryStringArraySerializationOptionCommaSeparated            // Arrays encoded with format: `key=value1,value2`
};

/**
 Serialization and deserialization between dictionaries and query strings.
 */
@interface CMDQueryStringSerialization : NSObject

/**
 Deserialize a query string into a dictionary. Calling this method is equivalent to calling `dictionaryWithQueryString:arrayOption:` and passing `CMDQueryStringArraySerializationOptionMultipleKeys`.
 
 @param string Query string to be deserialized
 */
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string;

/**
 Deserialize a query string into a dictionary.
 
 @param string Query string to be deserialized
 @param arrayOption Option to be used when deserializing array values
 */
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string arrayOption:(CMDQueryStringArraySerializationOption)arrayOption;

/**
 Serialize a dictionary into a query string. Calling this method is equivalent to calling `queryStringWithDictionary:arrayOption:` and passing `CMDQueryStringArraySerializationOptionMultipleKeys`.
 
 @param dictionary Dictionary to be serialized
 */
+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary;

/**
 Serialize a dictionary into a query string.
 
 @param dictionary Dictionary to be serialized
 @param arrayOption Option to be used when serializing array values
 */
+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary arrayOption:(CMDQueryStringArraySerializationOption)arrayOption;

@end
