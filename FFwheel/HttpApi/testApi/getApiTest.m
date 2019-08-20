//
//  getApiTest.m
//  FFwheel
//
//  Created by ffzp on 2019/8/13.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import "getApiTest.h"

@implementation getApiTest
{
    NSString *_userId;
}
-(id)initWithUserId:(NSString *)userId{
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}

-(NSString *)requestUrl{
    return [NSString stringWithFormat:@"/app/notToken"];
}

- (id)jsonValidator {
    return @{
             @"code": [NSNumber class],
             @"data": [NSString class],
             @"msg" : [NSString class]
             };
}

- (NSInteger)cacheTimeInSeconds {
    return 10;
}



@end
