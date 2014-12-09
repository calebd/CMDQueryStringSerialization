//
//  NSString+CMDQueryStringSerialization.h
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

// Check if the Compiler has Modules enabled.
#if defined(__has_feature) && __has_feature(modules)
@import Foundation;
#else
// otherwise use the legacy Objective-C/C++ compatible Header
#import <Foundation/Foundation.h>
#endif

@interface NSString (CMDQueryStringSerialization)

- (NSString *)cmd_stringByAddingEscapes;

- (NSString *)cmd_stringByRemovingEscapes;

@end
