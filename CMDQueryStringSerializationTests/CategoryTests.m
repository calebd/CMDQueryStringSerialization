//
//  CategoryTests.m
//  CMDQueryStringSerialization
//
//  Created by Sam Soffes on 6/1/15.
//  Copyright (c) 2015 Caleb Davenport. All rights reserved.
//

@import XCTest;
@import CMDQueryStringSerialization;

@interface CategoryTests : XCTestCase
@end

@implementation CategoryTests

- (void)testQueryDictionary {
    NSDictionary *desiredDictionary = @{
        @"key_one" : @"value_one",
        @"key_two" : @"value_two"
    };

    NSURL *URL = [NSURL URLWithString:@"http://apple.com"];
    URL = [URL cmd_URLWithQueryDictionary:desiredDictionary];

    NSDictionary *actualDictionary = URL.cmd_queryDictionary;
    XCTAssertEqualObjects(actualDictionary, desiredDictionary, @"Query parameters are incorrect.");
}

- (void)testReplaceQueryDictionary {
    NSURL *URL = [NSURL URLWithString:@"http://apple.com"];

    NSDictionary *firstDictionary = @{
        @"key_one" : @"value_one",
        @"key_two" : @"value_two"
    };
    NSDictionary *secondDictionary = @{
        @"key_three" : @"value_one",
        @"key_four" : @"value_two"
    };

    URL = [URL cmd_URLWithQueryDictionary:firstDictionary];
    XCTAssertEqualObjects(URL.cmd_queryDictionary, firstDictionary, @"Query parameters are incorrect.");

    URL = [URL cmd_URLWithQueryDictionary:secondDictionary];
    XCTAssertEqualObjects(URL.cmd_queryDictionary, secondDictionary, @"Query parameters are incorrect.");
}

- (void)testAddQueryDictionary {
    NSURL *URL = [NSURL URLWithString:@"http://apple.com"];

    NSDictionary *firstDictionary = @{
        @"key_one" : @"value_one",
        @"key_two" : @"value_two"
    };
    NSDictionary *secondDictionary = @{
        @"key_three" : @"value_one",
        @"key_four" : @"value_two"
    };

    NSMutableDictionary *mergedDictionary = [[NSMutableDictionary alloc] init];
    [mergedDictionary addEntriesFromDictionary:firstDictionary];
    [mergedDictionary addEntriesFromDictionary:secondDictionary];
    
    URL = [URL cmd_URLByAddingQueryDictionary:firstDictionary];
    XCTAssertEqualObjects(URL.cmd_queryDictionary, firstDictionary, @"Query parameters are incorrect.");
    
    URL = [URL cmd_URLByAddingQueryDictionary:secondDictionary];
    XCTAssertEqualObjects(URL.cmd_queryDictionary, mergedDictionary, @"Query parameters are incorrect.");
}

- (void)testEmptyQueryDictionary {
    NSURL *URL = [NSURL URLWithString:@"http://apple.com"];
    
    XCTAssertEqualObjects(URL.absoluteString, [URL cmd_URLWithQueryDictionary:nil].absoluteString);
    XCTAssertEqualObjects(URL.absoluteString, [URL cmd_URLWithQueryDictionary:@{}].absoluteString);

    XCTAssertEqualObjects(URL.absoluteString, [URL cmd_URLByAddingQueryDictionary:nil].absoluteString);
    XCTAssertEqualObjects(URL.absoluteString, [URL cmd_URLByAddingQueryDictionary:@{}].absoluteString);
}

- (void)testEncodeAndDecode {
    NSDictionary *parameters = @{
        @"message": @"Hello World",
        @"number": @42,
        @"favorite_things": @[ @"cats", @"flower bed spreads" ],
        @"dictionary": @{ @"stuff": @"things and whatnot" }
    };

    NSURL *URL = [NSURL URLWithString:@"http://apple.com"];
    URL = [URL cmd_URLByAddingQueryDictionary:parameters];
    XCTAssertEqualObjects(URL.cmd_queryDictionary, parameters);
}

@end
