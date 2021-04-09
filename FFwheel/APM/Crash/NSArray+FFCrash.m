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
//        //设置方法交换
//        Class nsArrayI = NSClassFromString(@"__NSArrayI");
//        FF_ExchangeInstanceMethod(nsArrayI, @selector(objectAtIndex:),nsArrayI, @selector(ff_objectAtIndex:));
//        FF_ExchangeInstanceMethod(nsArrayI, @selector(objectAtIndexedSubscript:), nsArrayI, @selector(ff_objectAtIndexedSubscript:));
//        FF_ExchangeInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:), NSClassFromString(@"__NSSingleObjectArrayI"), @selector(ff_singleObjectAtIndex:));
//        FF_ExchangeInstanceMethod(NSClassFromString(@"__NSPlaceholderArray"), @selector(initWithObjects:count:), NSClassFromString(@"__NSPlaceholderArray"), @selector(ff_initWithObjects:count:));
    });
}

// 越界
-(id)ff_objectAtIndex:(NSInteger)index{
    if(index >= self.count || !self.count){
        @try {
            return [self ff_objectAtIndex:index];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeArray errorDesc:[NSString stringWithFormat:@"info:[NSArray objectAtIndex]数组越界\n this index out of range: %li \n %@",index,exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
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
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeArray errorDesc:[NSString stringWithFormat:@"info:arr[index]数组越界\n this index out of range: %li \n %@",index,exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return self.lastObject;
        }
    }else{
        return [self ff_objectAtIndexedSubscript:index];
    }
}

- (id)ff_singleObjectAtIndex:(NSInteger)index{
    if(index >= self.count || !self.count){
        @try {
            return [self ff_singleObjectAtIndex:index];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeArray errorDesc:[NSString stringWithFormat:@"info:[NSArray singleObjectAtIndex]数组越界\n this index out of range: %li \n %@",index,exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return self.lastObject;
        }
    }else{
        return [self ff_singleObjectAtIndex:index];
    }
}

- (id)ff_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull _objects[cnt];
    for(int i = 0; i < cnt; i++){
        if(objects[i]){
            _objects[index] = objects[i];
            index++;
        }else{
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeArray errorDesc:[NSString stringWithFormat:@"异常:数组nil值 *** -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[%d]",i] e:nil callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }
    return [self ff_initWithObjects:_objects count:cnt];
}


@end
