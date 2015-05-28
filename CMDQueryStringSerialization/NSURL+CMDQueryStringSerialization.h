//
//  NSURL+CMDQueryStringSerialization.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 5/28/15.
//  Copyright (c) 2015 Caleb Davenport. All rights reserved.
//

@import Foundation;

@interface NSURL (CMDQueryStringSerialization)

@property (nonatomic, readonly) NSDictionary *cmd_queryDictionary;

- (NSURL *)cmd_URLWithQueryDictionary:(NSDictionary *)dictionary;

- (NSURL *)cmd_URLByAddingQueryDictionary:(NSDictionary *)dictionary;

@end
