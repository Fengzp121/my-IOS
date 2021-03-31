//
//  FFCrashHandle.h
//  FFwheel
//
//  Created by 你吗 on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FFCrashErrorType){
    FFCrashErrorTypeUnknow = 0,
    FFCrashErrorTypeArray,
    FFCrashErrorTypeMArray,
    FFCrashErrorTypeDictionary,
    FFCrashErrorTypeMDictionary,
    FFCrashErrorTypeString,
    FFCrashErrorTypeMString,
    FFCrashErrorTypeUnrecognizedSelector,
    FFCrashErrorTypeKVO,
    FFCrashErrorTypeKVC,
    FFCrashErrorTypeAsyncUpdateUI,
    FFCrashErrorTypeZombie,
    FFCrashErrorTypeMLeak
};

@interface FFCrashError : NSObject
/// 崩溃类型
@property(nonatomic, assign) FFCrashErrorType errorType;
/// 崩溃描述
@property(nonatomic, copy) NSString *errorDesc;
/// 异常对象
@property(nonatomic, strong)NSException *e;
/// 当前线程的函数调用栈
@property(nonatomic, copy) NSArray<NSString *> *callStack;

+ (instancetype)errorWithType:(FFCrashErrorType)errorType errorDesc:(NSString *)errorDesc e:(nullable NSException *)e callStack:(NSArray *)callStack;

@end

@class FFCrashHandle;
@protocol FFCrashHandleDelegate <NSObject>
///将异常信息抛出去给别人做收集处理
-(void)crashHandleDidOutputCrashError:(FFCrashError *)crashError;

@end

@interface FFCrashHandle : NSObject

@property(nonatomic, weak)id<FFCrashHandleDelegate> delegate;

+ (instancetype)defaultCrashHandler;
@end

NS_ASSUME_NONNULL_END
