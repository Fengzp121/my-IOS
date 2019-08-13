//
//  FFBusinessTier.h
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFRequestModel.h"
//面向业务层的文件
//把处理好的各种东西在这里发生请求和做各种操作
//
@interface FFBusinessTier : NSObject
//生成单例
+(instancetype)sharedInstance;
//根据requestmodel发出请求
-(NSNumber *)callRequestWithRequestModel:(FFRequestModel *)requestModel;
//取消请求操作
-(void)cancelRequestWithRequestID:(NSNumber *)requestID;
-(void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;
@end

 
