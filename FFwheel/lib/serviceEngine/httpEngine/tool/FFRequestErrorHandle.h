//
//  FFRequestErrorHandle.h
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFRequestModel.h"
@interface FFRequestErrorHandle : NSObject
//发生错误时在block中处理操作
+(void)errorHandleWithRequestdataModel:(FFRequestModel *)dataModel responseURL:(NSString *)resonserURL responseObject:(id)responseObject error:(NSError *)error errorHandler:(void(^)(NSError *newError))errorHandle;

@end


