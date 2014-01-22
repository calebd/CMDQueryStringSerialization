//
//  CMDQueryStringSerializationTests.m
//  CMDQueryStringSerializationTests
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

@import XCTest;

#import "CMDQueryStringSerialization.h"

@interface CMDQueryStringSerializationTests : XCTestCase

@end

@implementation CMDQueryStringSerializationTests

- (void)testOneKeyValuePair {
    NSDictionary *desiredDictionary = @{ @"key" : @"value" };
    NSString *desiredString = @"key=value";
    
    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");
    
    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testTwoKeyValuePairs {
    NSDictionary *desiredDictionary = @{
        @"key_one" : @"value_one",
        @"key_two" : @"value_two"
    };
    NSString *desiredString = @"key_one=value_one&key_two=value_two";
    
    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");
    
    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}

@end
