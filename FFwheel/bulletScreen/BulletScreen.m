//
//  BulletScreen.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/18.
//  Copyright © 2021 ffzp. All rights reserved.
//
/*
 目标就是每个弹幕是一个独立的对象，使用一个透明的画布遮挡。点击事件通过hittest穿透
 并支持可触控每一个单独的弹幕（点击暂停点赞之类的反正就是）
 根据视频或什么控制将弹幕滑动速度加快
 
 */

#import "BulletScreen.h"

@interface BulletScreen()

@end

@implementation BulletScreen

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

@end
