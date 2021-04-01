//
//  NSString+FFCrash.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/1.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "NSString+FFCrash.h"
#import "FFCrashTool.h"
@implementation NSString (FFCrash)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class stringClass = NSClassFromString(@"__NSCFConstantString");
        FF_ExchangeInstanceMethod(stringClass, @selector(characterAtIndex:), stringClass, @selector(characterAtIndex:));
        FF_ExchangeInstanceMethod(stringClass, @selector(substringFromIndex:), stringClass, @selector(ff_substringFromIndex:));
        FF_ExchangeInstanceMethod(stringClass, @selector(substringToIndex:), stringClass, @selector(ff_substringToIndex:));
        FF_ExchangeInstanceMethod(stringClass, @selector(substringWithRange:), stringClass, @selector(ff_substringWithRange:));
    });
}

-(unichar)ff_characterAtIndex:(NSUInteger)index{
    if(index >= self.length){
        @try {
            [self ff_characterAtIndex:index];
        } @catch (NSException *exception) {
            FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeString errorDesc:[@"异常:String越界 " stringByAppendingString:exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
        }
        return 0;
    }
    return [self ff_characterAtIndex:index];
}

-(NSString *)ff_substringFromIndex:(NSUInteger)from{
    id instance = nil;
    @try {
        instance = [self ff_substringFromIndex:from];
    } @catch (NSException *exception) {
        FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeString errorDesc:[@"异常:String越界 " stringByAppendingString:exception.reason] e:exception callStack:[NSThread callStackSymbols]];
        [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
    } @finally {
        return instance;
    }
}

-(NSString *)ff_substringToIndex:(NSUInteger)to{
    id instance = nil;
    @try {
        instance = [self ff_substringToIndex:to];
    } @catch (NSException *exception) {
        FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeString errorDesc:[@"异常:String越界 " stringByAppendingString:exception.reason] e:exception callStack:[NSThread callStackSymbols]];
        [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
    } @finally {
        return instance;
    }
}

- (NSString *)ff_substringWithRange:(NSRange)range{
    id instance = nil;
    @try {
        instance = [self ff_substringWithRange:range];
    }
    @catch (NSException *exception) {
        FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeString errorDesc:[@"异常:String越界 " stringByAppendingString:exception.reason] e:exception callStack:[NSThread callStackSymbols]];
        [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
    }
    @finally {
        return instance;
    }
}

@end
