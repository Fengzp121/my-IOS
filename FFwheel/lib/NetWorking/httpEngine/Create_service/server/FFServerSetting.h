//
//  FFServerSetting.h
//  FFwheel
//
//  Created by ffzp on 2019/1/21.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFBaseServer.h"
#import "Service_Config.h"

@interface FFServerSetting : NSObject
+(instancetype)sharedInstance;

//获取服务器地址的
-(FFBaseServer<FFBaseServerProtocol> *)serviceType:(FFServiceType)type;
@end


