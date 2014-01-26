//
//  CMDQueryStringSerialization.m
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDKeyValuePairString.h"
#import "CMDQueryStringSerialization.h"
#import "CMDQueryStringCommaSeparatedArrayTransformer.h"
#import "CMDQueryStringMultipleBracketedKeysArrayTransformer.h"
#import "CMDQueryStringMultipleKeysArrayTransformer.h"
#import "NSString+CMDQueryStringSerialization.h"

@interface NSMutableDictionary (CMDQueryStringSerialization)

- (void)cmd_addObject:(id)object forKey:(NSString *)key;

@end

@implementation CMDQueryStringSerialization

#pragma mark - Deserialization

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string {
    return [self dictionaryWithQueryString:string arrayOption:CMDQueryStringArraySerializationOptionMultipleKeys];
}

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string arrayOption:(CMDQueryStringArraySerializationOption)arrayOption {
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    [CMDKeyValuePairString enumeratePairsInString:string block:^(NSString *key, NSString *value) {
        if (arrayOption == CMDQueryStringArraySerializationOptionCommaSeparated) {
            NSArray *values = [value componentsSeparatedByString:@","];
            
            [values enumerateObjectsUsingBlock:^(NSString *commaSeparatedValue, NSUInteger index, BOOL *stop) {
                [result cmd_addObject:commaSeparatedValue forKey:key];
            }];
        }
        else {
            if (arrayOption == CMDQueryStringArraySerializationOptionMultipleBracketedKeys) {
                key = [key stringByReplacingOccurrencesOfString:@"[]" withString:@""];
            }
            
            [result cmd_addObject:value forKey:key];
        }
    }];
    
    return [result copy];
}

#pragma mark - Serialization

+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary {
    return [self queryStringWithDictionary:dictionary arrayOption:CMDQueryStringArraySerializationOptionMultipleKeys];
}

+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary arrayOption:(CMDQueryStringArraySerializationOption)arrayOption {
    NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:[dictionary count]];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        if ([value isKindOfClass:[NSArray class]]) {
            id <CMDQueryStringArrayTransformer> transformer = [self arrayTransformerForOption:arrayOption];
            [pairs addObjectsFromArray:[transformer keyValuePairStringsFromKey:key values:value]];
        }
        else {
            NSString *escapedKey = [key cmd_stringByAddingEscapes];
            NSString *escapedValue = [value cmd_stringByAddingEscapes];
            
            [pairs addObject:[CMDKeyValuePairString pairStringWithKey:escapedKey value:escapedValue]];
        }
    }];
    
    return [pairs componentsJoinedByString:@"&"];
}

#pragma mark - Private

+ (id <CMDQueryStringArrayTransformer>)arrayTransformerForOption:(CMDQueryStringArraySerializationOption)option {
    static NSDictionary *arraySerializationOptionsToTransformers;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arraySerializationOptionsToTransformers = @{
            @(CMDQueryStringArraySerializationOptionMultipleKeys) : [CMDQueryStringMultipleKeysArrayTransformer class],
            @(CMDQueryStringArraySerializationOptionMultipleBracketedKeys) : [CMDQueryStringMultipleBracketedKeysArrayTransformer class],
            @(CMDQueryStringArraySerializationOptionCommaSeparated) : [CMDQueryStringCommaSeparatedArrayTransformer class]
        };
    });
    
    return arraySerializationOptionsToTransformers[@(option)];
}

@end

@implementation NSMutableDictionary (CMDQueryStringSerialization)

- (void)cmd_addObject:(id)object forKey:(NSString *)key {
    id existingObject = self[key];
    
    if (existingObject) {
        if ([existingObject isKindOfClass:[NSArray class]]) {
            self[key] = [existingObject arrayByAddingObject:object];
        }
        else {
            self[key] = @[ existingObject, object ];
        }
    }
    else {
        self[key] = object;
    }
}

@end
