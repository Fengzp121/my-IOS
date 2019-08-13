//
//  FFtoolBarView.h
//  FFwheel
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018 apple. All rights reserved.
//
@class FFTableCellModel;
@interface FFTabBarView : UITabBar

@property (nonatomic,assign)FFTableCellModel *model;

@property (nonatomic,copy) void(^CenterBtn)(FFTabBarView *tab,UIButton * centerBtn);
@end


