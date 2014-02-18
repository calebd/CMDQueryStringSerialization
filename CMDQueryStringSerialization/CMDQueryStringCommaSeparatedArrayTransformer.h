//
//  CMDQueryStringCommaSeparatedArrayTransformer.h
//  CMDQueryStringSerialization
//
//  Created by Bryan Irace on 1/26/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDQueryStringArrayTransformer.h"

/**
 Transforms a key and array of values into a single key/value pair where the value contains the array's values separated by a comma.
 */
@interface CMDQueryStringCommaSeparatedArrayTransformer : NSObject <CMDQueryStringArrayTransformer>

@end
