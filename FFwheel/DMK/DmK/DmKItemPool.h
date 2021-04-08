//
//  DmKItemPool.h
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//
//弹幕缓存池
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DmKItem;

@interface DmKItemPool : NSObject

+(instancetype)shareInstance;

-(void)pushItem:(DmKItem *)item;

-(void)popItem:(DmKItem *)item;

@end

NS_ASSUME_NONNULL_END
