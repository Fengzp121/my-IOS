//
//  FFBaseServer.m
//  FFwheel
//
//  Created by ffzp on 2019/1/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFBaseServer.h"
#import "Service_Config.h"
@interface FFBaseServer()
@property(nonatomic,weak)id<FFBaseServerProtocol> FFprotocol;


@end

@implementation FFBaseServer
@synthesize privateKey = _privateKey, ApiURL = _ApiURL;

-(instancetype)init{
    self = [super init];
    if(self){
        if([self conformsToProtocol:@protocol(FFBaseServerProtocol)]){
            self.FFprotocol = (id<FFBaseServerProtocol>)self;
            self.environmentType = EnvironmentTypeRelease;      //默认只有这个环境了
        }
        else{
            NSAssert(NO, @"协议未实现");
        }
    }
    return self;
}

#pragma mark ---getter and setter
-(void)setEnvironmentType:(EnvironmentType)environmentType{
    _environmentType = environmentType;
    _ApiURL = nil;
}

//密钥，暂时没用到，加密的事情后面再想想
-(NSString *)privateKey{
    if(_privateKey == nil){
        _privateKey = @"123";
    }
    return _privateKey;
}

-(NSString *)ApiURL{
    if(_ApiURL == nil){
        _ApiURL = self.FFprotocol.releaseApiBaseUrl;
    }
    return _ApiURL;
}
@end
