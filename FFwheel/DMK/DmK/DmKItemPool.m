//
//  DmKItemPool.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "DmKItemPool.h"
#import "DmKItem.h"
#import "DmKItemProtocol.h"

@implementation DmKItemPool
{   //存储map，根据类型存储每一组弹幕。
    NSMutableDictionary<NSString *,NSMutableArray<id<DmKItemProtocol>>*> *_reusableItems;
}
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
        _reusableItems = [[NSMutableDictionary alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearReusableItems) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

-(void)clearReusableItems{
    [_reusableItems removeAllObjects];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private function




#pragma mark - public function
-(void)pushItem:(DmKItem *)item{
    
}

-(void)popItem:(DmKItem *)item{
    
}

@end
