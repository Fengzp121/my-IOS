//
//  NSMutableDictionary+FFCrash.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/1.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "NSMutableDictionary+FFCrash.h"
#import "FFCrashTool.h"
@implementation NSMutableDictionary (FFCrash)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class mDict = NSClassFromString(@"__NSDictionaryM");
        FF_ExchangeInstanceMethod(mDict, @selector(setObject:forKey:), mDict, @selector(ff_setObject:forKey:));
        FF_ExchangeInstanceMethod(mDict, @selector(removeObjectForKey:), mDict, @selector(ff_removeObjectForKey:));
        FF_ExchangeInstanceMethod(mDict, @selector(setObject:forKeyedSubscript:), mDict, @selector(ff_setObject:forKeyedSubscript:));
        FF_ExchangeInstanceMethod(mDict, @selector(initWithObjects:forKeys:count:), mDict, @selector(ff_initWithObjects:forKeys:count:));
    });
}

-(void)ff_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if(!anObject || !aKey){
        @try {
            [self ff_setObject:anObject forKey:aKey];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMDictionary errorDesc:[NSString stringWithFormat:@"object or key is nil %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }else{
        [self ff_setObject:anObject forKey:aKey];
    }
}


-(void)ff_removeObjectForKey:(id)aKey{
    if(!aKey){
        @try {
            [self ff_removeObjectForKey:aKey];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMDictionary errorDesc:[NSString stringWithFormat:@"object or key is nil %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }else{
        [self ff_removeObjectForKey:aKey];
    }
}

-(void)ff_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
    if(!obj || !aKey){
        @try {
            [self setObject:obj forKeyedSubscript:key];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMDictionary errorDesc:[NSString stringWithFormat:@"object or key is nil %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }else{
        [self setObject:obj forKeyedSubscript:key];
    }
}

-(id)ff_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull _objects[cnt];
    id<NSCopying> _Nonnull _keys[cnt];
    for (int i = 0; i < cnt; i++) {
        if(objects[i] && keys[i]){
            _objects[index] = objects[i];
            _keys[index] = keys[i];
            index++;
        }else{
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMDictionary errorDesc:[NSString stringWithFormat:@"object or key is nil "] e:nil callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }
    return [self ff_initWithObjects:_objects forKeys:keys count:index];
}

@end
