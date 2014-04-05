//
//  CMDQueryStringValueTransformer.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 2/18/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringSerialization.h"
#import "NSString+CMDQueryStringSerialization.h"

@protocol CMDQueryStringValueTransformer <NSObject>
@required

+ (NSString *)stringWithKey:(NSString *)key value:(id)value options:(CMDQueryStringWritingOptions)options;

@end

@interface CMDQueryStringValueTransformer : NSObject <CMDQueryStringValueTransformer>

@end
