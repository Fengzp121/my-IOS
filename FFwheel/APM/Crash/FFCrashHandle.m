//
//  FFCrashHandle.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "FFCrashHandle.h"

#import <mach/mach.h>
#import <mach/exc.h>

#import "BSBacktraceLogger.h"

@implementation FFCrashError
+(instancetype)errorWithType:(FFCrashErrorType)errorType errorDesc:(NSString *)errorDesc e:(NSException *)e callStack:(NSArray *)callStack{
    FFCrashError * error = [FFCrashError new];
    error.errorType = errorType;
    error.errorDesc = errorDesc;
    error.e         = e;
    error.callStack = callStack;
    return error;
}

@end

@implementation FFCrashHandle

+(instancetype)defaultCrashHandler{
    static FFCrashHandle *crashHandle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        crashHandle = [[FFCrashHandle alloc] init];
        [crashHandle setCaughtCrashHandler];
    });
    return crashHandle;
}

- (void)setCaughtCrashHandler{
    [self setMachHandler];
}

- (void)setMachHandler{
    mach_port_t server_port;
    
    ///创建异常端口
    kern_return_t kr = mach_port_allocate(mach_task_self(),MACH_PORT_RIGHT_RECEIVE,&server_port);
    assert(kr == KERN_SUCCESS);
    NSLog(@"创建异常消息端口: %d", server_port);
    
    /// 申请异常端口权限
    kr = mach_port_insert_right(mach_task_self(), server_port, server_port, MACH_MSG_TYPE_MAKE_SEND);
    assert(kr == KERN_SUCCESS);
    
    /// 设置异常端口 EXC_MASK_CRASH 捕获mach_crash会导致死锁
    kr = task_set_exception_ports(mach_task_self(), EXC_MASK_BAD_ACCESS, server_port, EXCEPTION_DEFAULT | MACH_EXCEPTION_CODES | MACH_EXCEPTION_ERRORS, THREAD_STATE_NONE);
    /// 循环等待异常
    [self setMachPortListener:server_port];
}

- (void)setMachPortListener:(mach_port_t)mach_port{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        /// 创建一个mach信号
        __Request__exception_raise_state_identity_t mach_message;
        mach_message.Head.msgh_size = 1024;
        mach_message.Head.msgh_local_port = mach_port;
        
        mach_msg_return_t mr;
        
        while (true) {
            
            /// 往端口持续发送空消息，并且接收消息
//            extern mach_msg_return_t        mach_msg(
//                mach_msg_header_t *msg,
//                mach_msg_option_t option,
//                mach_msg_size_t send_size,
//                mach_msg_size_t rcv_size,
//                mach_port_name_t rcv_name,
//                mach_msg_timeout_t timeout,
//                mach_port_name_t notify);
            mr = mach_msg(&mach_message.Head,
                          MACH_RCV_MSG | MACH_RCV_LARGE,
                          0,
                          mach_message.Head.msgh_size,
                          mach_message.Head.msgh_local_port,
                          MACH_MSG_TIMEOUT_NONE,
                          MACH_PORT_NULL);
            
            if (mr != MACH_MSG_SUCCESS && mr != MACH_RCV_TOO_LARGE){
                NSLog(@"error!");
            }
            
            /// 打印监听信息
            NSLog(@"FFCrashHandler Receive a mach message:[%d] , remote_port:%d, local_port:%d, exception code:%d",
                  mach_message.Head.msgh_id,
                  mach_message.Head.msgh_remote_port,
                  mach_message.Head.msgh_local_port,
                  mach_message.exception);

            NSString *callStack = [BSBacktraceLogger bs_backtraceOfAllThread];
            NSString *exceptionInfo = [NSString stringWithFormat:@"mach异常: %@",callStack];
            FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeUnknow errorDesc:exceptionInfo e:nil callStack:@[callStack]];
            [[FFCrashHandle defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
            //
            //abort();
        }
    });
}

@end
