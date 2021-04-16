//
//  FFCrashHandler.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "FFCrashHandler.h"

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

@implementation FFCrashHandler

+(instancetype)defaultCrashHandler{
    static FFCrashHandler *crashHandle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        crashHandle = [[FFCrashHandler alloc] init];
        [crashHandle setCaughtCrashHandler];
    });
    return crashHandle;
}

- (void)setCaughtCrashHandler{
//    [self setMachHandler];
//    [self setSignalHandler];
//    [self setExceptionHandler];
}

#pragma mark - mach_port crash catch
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
            NSLog(@"FFCrashHandlerr Receive a mach message:[%d] , remote_port:%d, local_port:%d, exception code:%d",
                  mach_message.Head.msgh_id,
                  mach_message.Head.msgh_remote_port,
                  mach_message.Head.msgh_local_port,
                  mach_message.exception);

            NSString *callStack = [BSBacktraceLogger bs_backtraceOfAllThread];
            NSString *exceptionInfo = [NSString stringWithFormat:@"mach异常: %@",callStack];
            FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeUnknow errorDesc:exceptionInfo e:nil callStack:@[callStack]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
            //
            //abort();
        }
    });
}

#pragma mark - unix signal crash catch
- (void)setSignalHandler{
    signal(SIGABRT, FF_UncaughtSignalHandler);
    signal(SIGILL, FF_UncaughtSignalHandler);
    signal(SIGSEGV, FF_UncaughtSignalHandler);
    signal(SIGFPE, FF_UncaughtSignalHandler);
    signal(SIGBUS, FF_UncaughtSignalHandler);
    signal(SIGPIPE, FF_UncaughtSignalHandler);
    signal(SIGKILL, FF_UncaughtSignalHandler);
    signal(SIGTRAP, FF_UncaughtSignalHandler);
}

void FF_UncaughtSignalHandler(int signal){
    NSString *exceptionInfo = [NSString stringWithFormat:@"异常信号:%@ Crash",signalName(signal)];
    FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeUnknow errorDesc:exceptionInfo e:nil callStack:[NSThread callStackSymbols]];
    [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
}

NSString *signalName(int signal){
    switch (signal) {
        case SIGABRT:
            return @"SIGBRT";
        case SIGILL:
            return @"SIGILL";
        case SIGSEGV:
            return @"SIGSEGV";
        case SIGFPE:
            return @"SIGFPE";
        case SIGBUS:
            return @"SIGBUS";
        case SIGPIPE:
            return @"SIGPIPE";
        case SIGKILL:
            return @"SIGKILL";
        case SIGTRAP:
            return @"SIGTRAP";
        default:
            return @"UNKOWN";
    }
}

#pragma mark - NSException catch
static NSUncaughtExceptionHandler *otherUncaughtExceptionHandler = NULL;

-(void)setExceptionHandler{
    //先获取别人捕获异常的handler
    otherUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    //然后注册自己的handler
    NSSetUncaughtExceptionHandler(setUncaughtExceptionHandler);
}

void setUncaughtExceptionHandler(NSException *e){
    if(otherUncaughtExceptionHandler){
        otherUncaughtExceptionHandler(e);
    }
    NSString *exceptionInfo = [NSString stringWithFormat:@"捕获异常:%@",e.reason];
    FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeUnknow errorDesc:exceptionInfo e:e callStack:[NSThread callStackSymbols]];
    [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
}


@end
