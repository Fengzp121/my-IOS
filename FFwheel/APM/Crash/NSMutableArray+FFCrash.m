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
//        Class nsArrayM = NSClassFromString(@"__NSArrayM");
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(objectAtIndex:), nsArrayM, @selector(ff_mObjectAtIndex:));
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(objectAtIndexedSubscript:), nsArrayM, @selector(ff_mobjectAtIndexedSubscript:));
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(removeObjectsInRange:), nsArrayM, @selector(ff_removeObjectsInRange:));
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(replaceObjectAtIndex:withObject:), nsArrayM, @selector(ff_replaceObjectAtIndex:withObject:));
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(replaceObjectsInRange:withObjectsFromArray:), nsArrayM, @selector(ff_replaceObjectsInRange:withObjectsFromArray:));
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(insertObject:atIndex:), nsArrayM, @selector(ff_insertObject:atIndex:));
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(insertObjects:atIndexes:), nsArrayM, @selector(ff_insertObjects:atIndexes:));
//        FF_ExchangeInstanceMethod(nsArrayM, @selector(initWithObjects:count:), nsArrayM, @selector(ff_initWithObjects:count:));
    });
}

-(id)ff_mObjectAtIndex:(NSInteger)index{
    if(index >= self.count || !self.count){
        @try {
            return [self ff_mObjectAtIndex:index];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
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
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return self.lastObject;
        }
    }else{
        return [self ff_mobjectAtIndexedSubscript:index];
    }
}

-(void)ff_removeObjectsInRange:(NSRange)range{
    if(range.location + range.length > self.count){
        FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界"] e:nil callStack:[NSThread callStackSymbols]];
        [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        return;
    }
    [self ff_removeObjectsInRange:range];
}

-(void)ff_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object{
    if(!object){
        FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界"] e:nil callStack:[NSThread callStackSymbols]];
        [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        return;
    }
    if(index >= self.count){
        @try {
            [self ff_replaceObjectAtIndex:index withObject:object];
        } @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }else{
        [self ff_replaceObjectAtIndex:index withObject:object];
    }
}

//越界
- (void)ff_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    if (range.location+range.length > self.count) {
        @try {
            return [self ff_replaceObjectsInRange:range withObjectsFromArray:otherArray];
        }
        @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }else{
        [self ff_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
}

- (void)ff_insertObject:(id)object atIndex:(NSInteger)index {
    if (!object) {
        FFCrashError *crashError = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:@"异常:数组nil值 ***  -[__NSArrayM insertObject:atIndex:]: object cannot be nil" e:nil callStack:[NSThread callStackSymbols]];
        [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:crashError];
        return;
    }
    if (index > self.count) {
        @try {
            return [self ff_insertObject:object atIndex:index];
        }
        @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }else {
        [self ff_insertObject:object atIndex:index];;
    }
}

- (void)ff_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    if (indexes.firstIndex > self.count || objects.count != (indexes.count)) {
        @try {
            return [self ff_insertObjects:objects atIndexes:indexes];
        }
        @catch (NSException *exception) {
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界 %@",exception.reason] e:exception callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
            return;
        }
        
    }
    [self ff_insertObjects:objects atIndexes:indexes];
}

- (id)ff_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull objectsNew[cnt];
    for (int i = 0; i<cnt; i++) {
        if (objects[i]) {
            objectsNew[index] = objects[i];
            index++;
        }else{
            FFCrashError *error = [FFCrashError errorWithType:FFCrashErrorTypeMArray errorDesc:[NSString stringWithFormat:@"crash info:数组越界"] e:nil callStack:[NSThread callStackSymbols]];
            [[FFCrashHandler defaultCrashHandler].delegate crashHandleDidOutputCrashError:error];
        }
    }
    return [self ff_initWithObjects:objectsNew count:index];
}



@end
