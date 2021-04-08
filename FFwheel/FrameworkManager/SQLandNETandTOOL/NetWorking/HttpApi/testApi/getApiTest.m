//
//  getApiTest.m
//  FFwheel
//
//  Created by ffzp on 2019/8/13.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import "getApiTest.h"
#import "AFNetworking.h"
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
    return [NSString stringWithFormat:@"/user/login"];
}

-(id)jsonValidator{
    return NULL;
}
//-(NSDictionary *)userInfo{
//    return @{@"token":@"eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiIxNiIsImlhdCI6MTU2NTgzNzY4MSwiZXhwIjoxNTY2NDQyNDgxfQ.B2v9M0NnziJOjEEaoXg8U8GgCJkZDm1RT760gvUyRZ07vK8F1Cgpvth4kkB-yFYaIGs9asXMmSzRAcrj7Mq-Vg"};
//}




@end
