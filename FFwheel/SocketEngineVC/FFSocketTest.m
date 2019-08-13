//
//  FFSocketTest.m
//  FFwheel
//
//  Created by ffzp on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFSocketTest.h"
@interface FFSocketTest()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket * _testSocket;
}
//asfghahffhsdfh
@end
@implementation FFSocketTest
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FFSocketTest *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance initSocket];
    });
    return instance;
}


-(void)initSocket{
    _testSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

}

//public
-(BOOL)connect{
        NSString *host = @"39.108.133.34";
        int port = 8888;
    return [_testSocket connectToHost:host onPort:port error:nil];
}

-(void)disconnect{
    [_testSocket disconnect];
}

-(void)sendMsg:(NSString *)msg{
    NSData *data =[msg dataUsingEncoding:NSUTF8StringEncoding];
    [_testSocket writeData:data withTimeout:-1 tag:110];
}

-(void)pullMsg{
    [_testSocket readDataWithTimeout:-1 tag:110];
    
}
//private


//delegate
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"好的连接到了fuck服务器了-----:%@:%d",host,port);
    [self pullMsg];
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"=======");
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *msg=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"msg%@:",msg);
    [self pullMsg];
}
@end
