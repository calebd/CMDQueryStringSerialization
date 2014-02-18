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
    return [self queryStringWithDictionary:dictionary options:kNilOptions];
}


+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary options:(CMDQueryStringWritingOptions)options {
    CMDQueryStringWriter *writer = [[CMDQueryStringWriter alloc] initWithDictionary:dictionary options:options];
    return [writer stringValue];
}

@end

//@interface NSMutableDictionary (CMDQueryStringSerialization)
//
//- (void)cmd_addObject:(id)object forKey:(NSString *)key;
//
//@end
//
//@interface NSNumber (CMDQueryStringSerialization)
//
//-(NSString *)cmd_stringByAddingEscapes;
//
//@end
//
//@implementation CMDQueryStringSerialization
//
//#pragma mark - Deserialization
//
//+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string {
//    return [self dictionaryWithQueryString:string arrayOption:CMDQueryStringArraySerializationOptionMultipleKeys];
//}
//
//<<<<<<< HEAD
//
//+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary {
//    if (!dictionary) {
//        return nil;
//    }
//    NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:[dictionary count]];
//    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
//        void (^addPair)(NSString *key, NSString *value) = ^(NSString *key, NSString *value) {
//            [pairs addObject:[NSString stringWithFormat:@"%@=%@",
//                              [key cmd_stringByAddingEscapes],
//                              [value cmd_stringByAddingEscapes]]];
//        };
//        
//        if ([value isKindOfClass:[NSArray class]]) {
//            for (NSString *valueFromArray in (NSArray *)value) {
//                addPair(key, valueFromArray);
//=======
//+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string arrayOption:(CMDQueryStringArraySerializationOption)arrayOption {
//    NSMutableDictionary *result = [NSMutableDictionary new];
//    
//    [CMDKeyValuePairString enumeratePairsInString:string block:^(NSString *key, NSString *value) {
//        if (arrayOption == CMDQueryStringArraySerializationOptionCommaSeparated) {
//            NSArray *values = [value componentsSeparatedByString:@","];
//            
//            [values enumerateObjectsUsingBlock:^(NSString *commaSeparatedValue, NSUInteger index, BOOL *stop) {
//                [result cmd_addObject:commaSeparatedValue forKey:key];
//            }];
//        }
//        else {
//            if (arrayOption == CMDQueryStringArraySerializationOptionMultipleBracketedKeys) {
//                key = [key stringByReplacingOccurrencesOfString:@"[]" withString:@""];
//>>>>>>> b1b6e17d5230b90e6590fa22976ff3b8be5fdef5
//            }
//            
//            [result cmd_addObject:value forKey:key];
//        }
//    }];
//    
//    return [result copy];
//}
//
//#pragma mark - Serialization
//
//- (void)cmd_enumeratePairs:(void (^) (NSString *key, NSString *value))block {
//    if ([self length] == 0) {
//        return;
//    }
//    NSArray *pairs = [self componentsSeparatedByString:@"&"];
//    [pairs enumerateObjectsUsingBlock:^(NSString *pair, NSUInteger index, BOOL *stop) {
//        NSRange range = [pair rangeOfString:@"="];
//        NSString *key, *value;
//        if (range.location == NSNotFound) {
//            key = [pair cmd_stringByRemovingEscapes];
//            value = @"";
//=======
//+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary {
//    return [self queryStringWithDictionary:dictionary arrayOption:CMDQueryStringArraySerializationOptionMultipleKeys];
//}
//
//+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary arrayOption:(CMDQueryStringArraySerializationOption)arrayOption {
//    NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:[dictionary count]];
//    
//    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
//        if ([value isKindOfClass:[NSArray class]]) {
//            id <CMDQueryStringArrayTransformer> transformer = [self arrayTransformerForOption:arrayOption];
//            [pairs addObjectsFromArray:[transformer keyValuePairStringsFromKey:key values:value]];
//>>>>>>> b1b6e17d5230b90e6590fa22976ff3b8be5fdef5
//        }
//        else {
//            NSString *escapedKey = [key cmd_stringByAddingEscapes];
//            NSString *escapedValue = [value cmd_stringByAddingEscapes];
//            
//            [pairs addObject:[CMDKeyValuePairString pairStringWithKey:escapedKey value:escapedValue]];
//        }
//    }];
//    
//    return [pairs componentsJoinedByString:@"&"];
//}
//
//#pragma mark - Private
//
//+ (id <CMDQueryStringArrayTransformer>)arrayTransformerForOption:(CMDQueryStringArraySerializationOption)option {
//    static NSDictionary *arraySerializationOptionsToTransformers;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        arraySerializationOptionsToTransformers = @{
//            @(CMDQueryStringArraySerializationOptionMultipleKeys) : [CMDQueryStringMultipleKeysArrayTransformer class],
//            @(CMDQueryStringArraySerializationOptionMultipleBracketedKeys) : [CMDQueryStringMultipleBracketedKeysArrayTransformer class],
//            @(CMDQueryStringArraySerializationOptionCommaSeparated) : [CMDQueryStringCommaSeparatedArrayTransformer class]
//        };
//    });
//    
//    return arraySerializationOptionsToTransformers[@(option)];
//}
//
//@end
