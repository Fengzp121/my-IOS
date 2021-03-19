//
//  DmKItem.h
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///弹幕的基类
@interface DmKItem : UIView

///参数字典
@property(nonatomic,copy)NSDictionary *viewParams;

///标记，yes时代表已经出现过
@property (nonatomic,assign,readonly,getter=isValid)BOOL valid;
@end

NS_ASSUME_NONNULL_END
