//
//  RequestMaker.m
//  FFwheel
//
//  Created by ffzp on 2020/9/14.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "RequestMaker.h"
#import <pthread/pthread.h>
@interface RequestMaker()

@end
@implementation RequestMaker{
    AFHTTPSessionManager *_manager;
    AFJSONResponseSerializer *_jsonResponseSerializer;
    AFXMLParserResponseSerializer *_xmlParserResponseSerialzier;
    NSMutableDictionary<NSNumber *, id> *_requestsRecord;

    dispatch_queue_t _processingQueue;
    pthread_mutex_t _lock;
    NSIndexSet *_allStatusCodes;
}
+(instancetype)ShareInstance{
    static RequestMaker *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPSessionManager alloc]init];
        //[self.manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"x-app-type"];
        //[self.manager.requestSerializer setValue:@"beta" forHTTPHeaderField:@"x-app-version"];
        //[self.manager.requestSerializer setTimeoutInterval:10];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        [_manager.securityPolicy setValidatesDomainName:NO];
        _requestsRecord = [NSMutableDictionary dictionary];
        _processingQueue = dispatch_queue_create("com.FFwheelDemo.networkagent.processing", DISPATCH_QUEUE_CONCURRENT);
        _allStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 500)];
        pthread_mutex_init(&_lock, NULL);

    }
    return self;
}




@end
