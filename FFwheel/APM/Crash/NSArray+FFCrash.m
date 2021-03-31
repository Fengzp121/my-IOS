//
//  NSArray+FFCrash.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "NSArray+FFCrash.h"
#import "FFCrashTool.h"

@implementation NSArray (FFCrash)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //设置方法交换
        FF_ExchangeInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:), NSClassFromString(@"__NSArrayI"), @selector(ff_objectAtIndex:));
        FF_ExchangeInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:), NSClassFromString(@"__NSArrayI"), @selector(ff_objectAtIndexedSubscript:));
    });
}
// 越界
-(id)ff_objectAtIndex:(NSInteger)index{
    if(index >= self.count || !self.count){
        @try {
            return [self ff_objectAtIndex:index];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeArray errorDesc:[NSString stringWithFormat:@"info:objectAtIndex数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandle defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return self.lastObject;
        }
    }else{
        return [self ff_objectAtIndex:index];
    }
}

-(id)ff_objectAtIndexedSubscript:(NSInteger)index{
    if(index >= self.count || !self.count){
        @try {
            return [self ff_objectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeArray errorDesc:[NSString stringWithFormat:@"info:arr[index]数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandle defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return self.lastObject;
        }
    }else{
        return [self ff_objectAtIndexedSubscript:index];
    }
}




@end
