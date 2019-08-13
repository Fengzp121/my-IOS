//
//  FFServer.m
//  FFwheel
//
//  Created by ffzp on 2019/1/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFServer.h"
@interface FFServer()
{
    NSString * _serverHeader;
}

@end
@implementation FFServer
@synthesize releaseApiBaseUrl = _releaseApiBaseUrl;

-(id)init{
    if(self = [super init]){
        //设置服务器头
        //_serverHeader = @"39.108.133.34:8909";
    }
    return self;
}

- (NSString *)releaseApiBaseUrl {
    if (_releaseApiBaseUrl == nil) {
        _releaseApiBaseUrl = @"http://39.108.133.34:8909";
    }
    return _releaseApiBaseUrl;
}

@end
