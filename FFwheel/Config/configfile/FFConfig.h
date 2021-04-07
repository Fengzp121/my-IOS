//
//  FFConfig.h
//  videoEditTest
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018 apple. All rights reserved.
//

#ifndef FFConfig_h
#define FFConfig_h

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height == 812.0f || [[UIScreen mainScreen] bounds].size.height >= 896.0f)

#define SafeAreaBottom (IS_IPHONE_X ? 34 : 0)
#define SafeAreaTop    (IS_IPHONE_X ? 44 : 20)
#define SafeNavigatorTop   (IS_IPHONE_X ? 88 : 64)

#define FFScreenHeight [[UIScreen mainScreen] bounds].size.height
#define FFScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define weak(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define strong(strongSelf) __strong __typeof(&*self)strongSelf = self;

#define setWeak(type) __weak __typeof(type) weak##type = type;
#define setStrong(type) __strong __typeof(type) strong##type = type;

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

#endif /* FFConfig_h */
