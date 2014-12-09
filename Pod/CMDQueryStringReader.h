//
//  CMDQueryStringReader.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

// Check if the Compiler has Modules enabled.
#if defined(__has_feature) && __has_feature(modules)
@import Foundation;
#else
// otherwise use the legacy Objective-C/C++ compatible Header
#import <Foundation/Foundation.h>
#endif

@interface CMDQueryStringReader : NSObject

- (instancetype)initWithString:(NSString *)string;

- (NSDictionary *)dictionaryValue;

@end
