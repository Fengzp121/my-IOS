//
//  DmKItemPool.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "DmKItemPool.h"

@interface DmKItemPool()


@end

@implementation DmKItemPool

+(instancetype)shareInstance{
    static DmKItemPool *pool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pool = [[DmKItemPool alloc] init];
    });
    return pool;
}

- (instancetype)init
{
    if (self = [super init]) {
        _reusableViews = [[NSMutableDictionary alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearReusableSpriteViews) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

-(void)pushItem:(DmKItem *)item{
    
}

-(void)popItem:(DmKItem *)item{
    
}

@end
