//
//  NSString+tojson.m
//  FFwheel
//
//  Created by ffzp on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NSString+tojson.h"

@implementation NSString(tojson)
-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
