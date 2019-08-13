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

#import "HelloWorldVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UINavigationController *nav = [[FFNavigationViewController alloc]initWithRootViewController:[[HelloWorldVC alloc]init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}


 



@end
