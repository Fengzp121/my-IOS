//
//  NSDictionary+FFCrash.m
//  FFwheel
//
//  Created by ffzp on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "NSDictionary+FFCrash.h"
#import "FFCrashTool.h"

@implementation NSDictionary (FFCrash)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionary = NSClassFromString(@"NSDictionary");
        FF_ExchangeInstanceMethod(dictionary, @selector(initWithObjects:forKeys:), dictionary, @selector(ff_initWithObjects:forKeys:));
        
        Class __NSPlaceholderDictionaryClass = NSClassFromString(@"__NSPlaceholderDictionary");
        FF_ExchangeInstanceMethod(__NSPlaceholderDictionaryClass, @selector(initWithObjects:forKeys:count:), __NSPlaceholderDictionaryClass, @selector(ff_initWithObjects:forKeys:count:));
    });
}

-(id)ff_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys{
    if(objects.count != keys.count){
        FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:字典的key与value数量不匹配 *** -[NSDictionary initWithObjects:forKeys:]: objects's count: %li , keys's count: %li",objects.count,keys.count] e:nil callStack:[NSThread callStackSymbols]];
        [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        return nil;
    }
    NSUInteger index = 0;
    id _Nonnull _objects[objects.count];
    id<NSCopying> _Nonnull _keys[keys.count];
    for (int i = 0; i < objects.count; i++) {
        if(objects[i] && keys[i]){
            _objects[index] = objects[i];
            _keys[index] = keys[i];
            index++;
        }else{
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeDictionary errorDesc:[NSString stringWithFormat:@"crash info: *** -[NSDictionary initWithObjects:forKeys:]: index of object or key is nil:%i",i] e:nil callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }
    return [self ff_initWithObjects:[NSArray arrayWithObjects:_objects count:index] forKeys:[NSArray arrayWithObjects:_keys count:index]];
}

- (id)ff_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull objectsNew[cnt];
    id <NSCopying> _Nonnull keysNew[cnt];
    //'*** -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)'
    for (int i = 0; i<cnt; i++) {
        if (objects[i] && keys[i]) {//可能存在nil的情况
            objectsNew[index] = objects[i];
            keysNew[index] = keys[i];
            index ++;
        }else{
            NSString *errorInfo = [NSString stringWithFormat:@"异常:字典nil值 *** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]",i];
            FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeDictionary errorDesc:errorInfo e:nil callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
        }
    }
    return [self ff_initWithObjects:objectsNew forKeys:keysNew count:index];
}


@end
