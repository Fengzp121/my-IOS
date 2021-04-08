//
//  getDynamicApi.m
//  FFwheel
//
//  Created by ffzp on 2019/8/15.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import "getDynamicApi.h"

@implementation getDynamicApi
{
    NSString *_page;
}
-(id)initWithPage:(NSString *)page{
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}

-(NSString *)requestUrl{
    return [NSString stringWithFormat:@"/dynamic/recommended?page=%@",_page];
}
//
//- (id)jsonValidator {
//    return @{
//             @"code": [NSNumber class],
//             @"data": [NSString class],
//             @"msg" : [NSString class]
//             };
//}

- (NSInteger)cacheTimeInSeconds {
    return 10;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return @{@"token":@"eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxNiIsImlhdCI6MTU2NTgzNzY4MSwiZXhwIjoxNTY2NDQyNDgxfQ.B2v9M0NnziJOjEEaoXg8U8GgCJkZDm1RT760gvUyRZ07vK8F1Cgpvth4kkB-yFYaIGs9asXMmSzRAcrj7Mq-Vg"};
}

@end
