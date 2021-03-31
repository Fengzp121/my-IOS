//
//  AppDelegate.m
//  videoEditTest
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "FFNavigationViewController.h"
#import "YTKNetworkConfig.h"
#import "urlArgumentsFilter.h"
#import "HelloWorldVC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setupRequestFilters {
    //NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    //urlArgumentsFilter *urlFilter = [urlArgumentsFilter filterWithArguments:@{@"version": appVersion}];
    //[config addUrlFilter:urlFilter];
    config.baseUrl = @"http://192.168.199.204:8888";
    //config.cdnUrl = @"hf";
}

-(void)log{
    NSLog(@"token-expire");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRequestFilters];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(log) name:@"token_expire" object:nil];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[HelloWorldVC alloc]init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}


 



@end
