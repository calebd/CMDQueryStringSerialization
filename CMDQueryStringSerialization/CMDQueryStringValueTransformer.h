//
//  CMDQueryStringValueTransformer.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

@protocol CMDQueryStringValueTransformer <NSObject>
@required

+ (NSString *)stringWithKey:(NSString *)key value:(id)value;

@end
