//
//  CMDQueryStringSerializationTests.m
//  CMDQueryStringSerializationTests
//
//  Created by Caleb Davenport on 1/21/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

@import XCTest;
@import CMDQueryStringSerialization;

@interface CMDQueryStringSerializationTests : XCTestCase

@end

@implementation CMDQueryStringSerializationTests

- (void)testOneKeyValuePair {
    NSString *desiredString = @"key=value";
    NSDictionary *desiredDictionary = @{ @"key" : @"value" };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testTwoKeyValuePairs {
    NSString *desiredString = @"key_one=value_one&key_two=value_two";
    NSDictionary *desiredDictionary = @{
        @"key_one" : @"value_one",
        @"key_two" : @"value_two"
    };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testQueryStringWithRepeatingParameterNoBrackets {
    NSString *desiredString = @"key=one&key=two";
    NSDictionary *desiredDictionary = @{
        @"key" : @[ @"one", @"two" ]
    };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary options:CMDQueryStringWritingOptionArrayRepeatKeys];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testQueryStringWithRepeatingParameterWithBrackets {
    NSString *desiredString = @"key[]=one&key[]=two";
    NSDictionary *desiredDictionary = @{
        @"key" : @[ @"one", @"two" ]
    };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary options:CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testQueryStringWithCommaDelimitedValue {
    NSString *desiredString = @"key=one,two";
    NSDictionary *desiredDictionary = @{
        @"key" : @[ @"one", @"two" ]
    };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary options:CMDQueryStringWritingOptionArrayCommaSeparatedValues];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testQueryStringWithEmoji {
    NSString *desiredString = @"grinning=%F0%9F%98%81&winking=%F0%9F%98%89";
    NSDictionary *desiredDictionary = @{
        @"grinning" : @"😁",
        @"winking" : @"\U0001F609"
    };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testNilQueryString {
    NSDictionary *nilDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:nil];
    XCTAssertNil(nilDictionary);
}


- (void)testNilDictionary {
    NSString *nilString = [CMDQueryStringSerialization queryStringWithDictionary:nil];
    XCTAssertNil(nilString);
}


- (void)testEmptyQueryString {
    NSString *desiredString = @"";
    NSDictionary *desiredDictionary = @{ };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testEmptyQueryStringKey {
    NSString *desiredString = @"=value";
    NSDictionary *desiredDictionary = @{ @"" : @"value" };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testEmptyQueryStringValue {
    NSString *desiredString = @"key=";
    NSDictionary *desiredDictionary = @{ @"key" : @"" };

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:desiredString];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testQueryStringWithoutEqualCharacter {
    NSDictionary *desiredDictionary = @{ @"key" : @"" };

    NSDictionary *actualDictionary = [CMDQueryStringSerialization dictionaryWithQueryString:@"key"];
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}


- (void)testDictionaryWithUnserializableKey {
    NSDictionary *desiredDictionary = @{ [NSDate date] : @"value" };

    XCTAssertThrowsSpecificNamed([CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary], NSException, NSInvalidArgumentException);
}


- (void)testDictionaryWithDateAsUnixTimestamp {
    NSDate *inputDate = [NSDate date];
    NSDictionary *inputDictionary = @{
                                      @"date" : inputDate
                                      };
    NSString *desiredString = [NSString stringWithFormat:@"date=%@", @((NSInteger)[inputDate timeIntervalSince1970])];

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:inputDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query string is incorrect.");
}


- (void)testDictionaryWithNumber {
    NSDictionary *desiredDictionary = @{ @"key": @13 };
    NSString *desiredString = @"key=13";

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query parameters are incorrect.");
}


- (void)testDictionaryWithFloatingPointNumber {
    NSDictionary *desiredDictionary = @{ @"key": @13.12 };
    NSString *desiredString = @"key=13.12";

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query parameters are incorrect.");
}


- (void)testDictionaryWithBooleanYES {
    NSDictionary *desiredDictionary = @{ @"key": @YES };
    NSString *desiredString = @"key=1";

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query parameters are incorrect.");
}


- (void)testDictionaryWithBooleanNO {
    NSDictionary *desiredDictionary = @{ @"key": @NO };
    NSString *desiredString = @"key=0";

    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:desiredDictionary];
    XCTAssertEqualObjects(actualString, desiredString, @"Query parameters are incorrect.");
}

- (void)testDateAsISO8601String {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1406759723];
    NSString *desiredString = @"date=2014-07-30T15%3A35%3A23-07%3A00";
    
    NSDictionary *dictionary = @{ @"date": date };
    
    NSString *actualString = [CMDQueryStringSerialization queryStringWithDictionary:dictionary options:CMDQueryStringWritingOptionDateAsISO8601String];
    XCTAssertEqualObjects(actualString, desiredString, @"Query parameters are incorrect.");
}

@end
