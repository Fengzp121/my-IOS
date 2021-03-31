//
//  NSMutableArray+FFCrash.m
//  FFwheel
//
//  Created by ffzp on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "NSMutableArray+FFCrash.h"
#import "FFCrashTool.h"

@implementation NSMutableArray (FFCrash)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FF_ExchangeInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:), NSClassFromString(@"__NSArrayM"), @selector(ff_mObjectAtIndex:));
        FF_ExchangeInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:), NSClassFromString(@"__NSArrayM"), @selector(ff_mobjectAtIndexedSubscript:));
    });
}

-(id)ff_mObjectAtIndex:(NSInteger)index{
    if(index >= self.count || !self.count){
        @try {
            return [self ff_mObjectAtIndex:index];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandle defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return self.lastObject;
        }
    }else{
        return [self ff_mObjectAtIndex:index];
    }
    
}

-(id)ff_mobjectAtIndexedSubscript:(NSInteger)index{
    if(index >= self.count || !self.count){
        @try {
            return [self ff_mobjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandle defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return self.lastObject;
        }
    }else{
        return [self ff_mobjectAtIndexedSubscript:index];
    }
}


@end
