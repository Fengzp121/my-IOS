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
    config.baseUrl = @"http://39.108.188.145:8077";
    config.cdnUrl = @"hf";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRequestFilters];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UINavigationController *nav = [[FFNavigationViewController alloc]initWithRootViewController:[[HelloWorldVC alloc]init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}


 



@end
