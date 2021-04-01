//
//  NSMutableString+FFCrash.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/1.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "NSMutableString+FFCrash.h"
#import "FFCrashTool.h"
@implementation NSMutableString (FFCrash)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class mStringClass = NSClassFromString(@"");
        FF_ExchangeInstanceMethod(mStringClass, @selector(insertString:atIndex:), mStringClass, @selector(ff_insertString:atIndex:));
        FF_ExchangeInstanceMethod(mStringClass, @selector(deleteCharactersInRange:), mStringClass, @selector(ff_deleteCharactersInRange:));
    });
}

-(void)ff_insertString:(NSString *)aString atIndex:(NSUInteger)loc{
    if (loc > self.length) {
        @try {
            [self ff_insertString:aString atIndex:loc];
        } @catch (NSException *exception) {
            FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeMString errorDesc:[@"异常:mString越界 " stringByAppendingString:exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
        }
    }else{
        [self ff_insertString:aString atIndex:loc];
    }
}

-(void)ff_deleteCharactersInRange:(NSRange)range{
    if(range.location+range.length > self.length){
        @try {
            [self ff_deleteCharactersInRange:range];
        } @catch (NSException *exception) {
            FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeMString errorDesc:[@"异常:mString越界 " stringByAppendingString:exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
        }
    }else{
        [self ff_deleteCharactersInRange:range];
    }
}

@end
