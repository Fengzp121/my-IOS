//
//  FFBaseServer.h
//  FFwheel
//
//  Created by ffzp on 2019/1/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,EnvironmentType) {
    
    EnvironmentTypeRelease,         //目前先只有一个环境
};

@protocol FFBaseServerProtocol <NSObject>

@property (nonatomic, strong, readonly) NSString *releaseApiBaseUrl;

@end

@interface FFBaseServer : NSObject
@property (nonatomic,assign)EnvironmentType environmentType;     //环境设置，不过还没弄其他环境

@property (nonatomic,strong,readonly)NSString *privateKey;      //加密私钥
@property (nonatomic,strong,readonly)NSString *ApiURL;          //接口头
@end

