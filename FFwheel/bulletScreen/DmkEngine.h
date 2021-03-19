//
//  DmkEngine.h
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DmkEngine;
@protocol DmkEngineDelegate <NSObject>


@end


@interface DmkEngine : NSObject

//opearte
///开始
-(void)start;
///结束
-(void)end;
///暂停
-(void)pause;

///接收弹幕数据
-(void)receive:(id)arr;

//property

@property (nonatomic,strong)UIView *dmkView;


//config

@property (nonatomic,weak)id<DmkEngineDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
