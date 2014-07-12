//
//  CMDQueryStringWritingOptions.h
//  CMDQueryStringSerialization
//
//  Created by Caleb Davenport on 7/11/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, CMDQueryStringWritingOptions) {
    
    // Default: Arrays encoded with format: `key=value1&key=value2`
    CMDQueryStringWritingOptionArrayRepeatKeys = 1 << 4,
    
    // Arrays encoded with format: `key[]=value1&key[]=value2`
    CMDQueryStringWritingOptionArrayRepeatKeysWithBrackets = 2 << 4,
    
    // Arrays encoded with format: `key=value1,value2`
    CMDQueryStringWritingOptionArrayCommaSeparatedValues = 3 << 4,
    
    // Dates encoded as Unix time stamps
    CMDQueryStringWritingOptionDateAsUnixTimestamp = 1 << 8
};
