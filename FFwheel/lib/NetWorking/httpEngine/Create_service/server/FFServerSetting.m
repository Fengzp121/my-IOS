//
//  FFServerSetting.m
//  FFwheel
//
//  Created by ffzp on 2019/1/21.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFServerSetting.h"
#import "FFServer.h"
#import "TLServer.h"
@interface FFServerSetting()

@property (nonatomic,strong)NSMutableDictionary *serviceStroage;    //服务器地址存贮器

@end
@implementation FFServerSetting
#pragma mark ----public func
//延长生命周期，不让它每次调用api都弄一个。
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FFServerSetting *sharedInstace;
    dispatch_once(&onceToken,^{
        sharedInstace = [[FFServerSetting alloc] init];
    });
    return sharedInstace;
}

//添加到容器中
-(FFBaseServer<FFBaseServerProtocol> *)serviceType:(FFServiceType)type{
    if(self.serviceStroage[@(type)] == nil){
        self.serviceStroage[@(type)] = [self makeServiceType:type];
    }
    return self.serviceStroage[@(type)];
}

#pragma mark ----private func
//选择服务器
-(FFBaseServer<FFBaseServerProtocol> *)makeServiceType:(FFServiceType)type{
    FFBaseServer<FFBaseServerProtocol> *service = nil;
    switch (type) {
        case FFService:
            service = [[FFServer alloc] init];
            break;
        case TLService:
            service = [[TLServer alloc] init];
            break;
        default:
            break;
    }
    return service;
}


#pragma mark ----lazy load
-(NSMutableDictionary *)serviceStroage{
    if(_serviceStroage == nil){
        _serviceStroage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStroage;
}

@end
