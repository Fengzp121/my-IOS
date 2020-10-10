//
//  FFCancelRequest.m
//  FFwheel
//
//  Created by ffzp on 2019/1/21.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFCancelRequest.h"
@interface FFCancelRequest()

@property (nonatomic,strong)NSMutableDictionary<NSNumber *,FFBaseEngine *> *requestEngine;              //数字字典存储请求的ID和相应的请求

@end
@implementation FFCancelRequest
-(void)dealloc{
    //清空字典
    [self.requestEngine removeAllObjects];
    self.requestEngine = nil;
}

//将需要中断的请求ID存入字典
-(void)setEngine:(FFBaseEngine *)engine requestID:(NSNumber *)requestID{
    if(engine && requestID){
        self.requestEngine[requestID] = engine;
    }
}

//清除字典中的不需要中断请求的ID
-(void)removeEngine_RequestWithRequestID:(NSNumber *)requestID{
    if(requestID){
        [self.requestEngine removeObjectForKey:requestID];
    }
}

-(NSMutableDictionary *)requestEngine{
    if(_requestEngine == nil){
        _requestEngine = [[NSMutableDictionary alloc] init];
    }
    return _requestEngine;
}
@end
