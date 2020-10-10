//
//  FFCancelRequest.h
//  FFwheel
//
//  Created by ffzp on 2019/1/21.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFBaseEngine.h"

@interface FFCancelRequest : NSObject
-(void)setEngine:(FFBaseEngine *)engine requestID:(NSNumber *)requestID;            //获取请求ID
-(void)removeEngine_RequestWithRequestID:(NSNumber *)requestID;                     //根据ID取消请求
@end


