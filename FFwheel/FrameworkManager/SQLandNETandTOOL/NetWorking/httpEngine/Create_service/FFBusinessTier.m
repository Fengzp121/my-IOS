//
//  FFBusinessTier.m
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFBusinessTier.h"
#import "AFURLSessionManager.h"
#import "FFRequestGenerator.h"
#import "FFRequestErrorHandle.h"
@interface FFBusinessTier()
//AFNet的manager
@property (nonatomic,strong)AFURLSessionManager *sessionManager;
// 根据 requestid，存放 task
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

@end

@implementation FFBusinessTier
//呵呵
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FFBusinessTier *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FFBusinessTier alloc] init];
    });
    return sharedInstance;
}

-(NSNumber *)callRequestWithRequestModel:(FFRequestModel *)requestModel{
    //请求头
    NSURLRequest *request = [[FFRequestGenerator sharedInstance]generateWithRequestDataModel:requestModel];
    AFURLSessionManager *sessionManager = self.sessionManager;
    
    //不要在意这个warning
    weak(weakSelf)
    NSURLSessionDataTask *updataTask = nil;
    updataTask = [sessionManager dataTaskWithRequest:request uploadProgress:requestModel.uploadProgressBlock downloadProgress:requestModel.downloadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response,id _Nonnull responseObject,NSError * _Nullable error){
        if(updataTask.state == NSURLSessionTaskStateCanceling){
         //请求被取消
        }else{
            NSNumber *requestID = [NSNumber numberWithUnsignedInteger:updataTask.hash];
            [weakSelf.dispatchTable removeObjectForKey:requestID];
            //检测是否有error，然后给上层回调
            [FFRequestErrorHandle errorHandleWithRequestdataModel:requestModel responseURL:requestModel.apiMethodPath responseObject:responseObject error:error errorHandler:^(NSError *newError) {
                requestModel.responseBlock(responseObject, newError);
            }];
        }
    }];
    [updataTask resume];            //发起请求
    NSNumber *requestID = [NSNumber numberWithUnsignedInteger:updataTask.hash];
    [self.dispatchTable setObject:updataTask forKey:requestID]; //把这个请求加到字典中
    return requestID;
}

-(void)cancelRequestWithRequestID:(NSNumber *)requestID{
    NSURLSessionDataTask *task = [self.dispatchTable objectForKey:requestID];
    [task cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

-(void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList{
    weak(weakSelf)
    [requestIDList enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSessionDataTask *task = [weakSelf.dispatchTable objectForKey:obj];
        [task cancel];
    }];
    [self.dispatchTable removeObjectsForKeys:requestIDList];
}
#pragma mark -----private func
//配置session
-(AFURLSessionManager *)setSessionManager{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:5*1024*1024 diskCapacity:10*1024*1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForResource = 60.0f;
    AFURLSessionManager *abc = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
        return abc;
}

#pragma mark -----lazy load
-(AFURLSessionManager *)sessionManager{
    if(_sessionManager == nil){
        _sessionManager = [self setSessionManager];
        
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
        //_sessionManager.responseSerializer = [AFJSONRequestSerializer serializer];
    }
    return _sessionManager;
}

-(NSMutableDictionary *)dispatchTable{
    if(_dispatchTable == nil){
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}
@end
