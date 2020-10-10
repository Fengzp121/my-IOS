//
//  main.m
//  videoEditTest
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void CrashExceptionHandler(NSException *exception);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //cleanCode
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        } @catch (NSException *exception) {
            CrashExceptionHandler(exception);
        } @finally {

        }
    }
}

//捕捉异常信息，cleanCode
void CrashExceptionHandler(NSException *exception){
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name   = [exception name];
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithContentsOfFile:[caches stringByAppendingPathComponent:@"FFwheel_crash.plist"]];
    if(!dicM){
        dicM = [NSMutableDictionary dictionary];
    }
    NSString *timesTmap = [VTGeneralTool getDateStamp];
    NSDictionary *dic = @{
                          timesTmap : @{
                                    [timesTmap stringByAppendingString:@"name"] : name,
                                    [timesTmap stringByAppendingString:@"_reason"] : reason,
                                    [timesTmap stringByAppendingString:@"__symbols"] :symbols
                                  }
                          };
    [dicM setValuesForKeysWithDictionary:dic];
    [dicM writeToFile:[caches stringByAppendingPathComponent:@"FFwheel_crash.plist"] atomically:YES];
}
