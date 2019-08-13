//
//  FFtoolBarView.m
//  FFwheel
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTabBarView.h"
@interface FFTabBarView()

@property (nonatomic,weak)UIButton *cenBtn;

@end
@implementation FFTabBarView

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setUI];
}

-(void)setUI{
    CGFloat itemWidth = self.frame.size.width / (self.items.count + 1);
    __block CGFloat itemY = 0;
    __block CGFloat itemHeight = 0;
    NSMutableArray<UIView *> *tabBarButtonArray = [NSMutableArray array];
    [self.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtonArray addObject:obj];
            obj.mj_w = itemWidth;
            itemY = obj.frame.origin.y;
            itemHeight = obj.frame.size.height;
        }
    }];
    
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.mj_x = idx * itemWidth;
        if(idx > 1){
            obj.mj_x = (idx + 1) * itemWidth;
        }
        if(idx == 2){
            [self.cenBtn sizeToFit];
            self.cenBtn.mj_size = CGSizeMake(itemWidth, itemHeight);
            self.cenBtn.center = CGPointMake(self.frame.size.width * 0.5, self.center.y) ;
            self.cenBtn.mj_y = itemY;
        }
    }];
    [self bringSubviewToFront:self.cenBtn];
}

-(UIButton *)cenBtn{
    if (_cenBtn == nil) {
        UIButton *cenBtn = [[UIButton alloc] init];
        [self addSubview:cenBtn];
        _cenBtn = cenBtn;
        
        [cenBtn setImage:[UIImage imageNamed:@"countBtn"] forState:UIControlStateNormal];
        //未设置完成button的图片
        [cenBtn setImage:[UIImage imageNamed:@"countBtn"] forState:UIControlStateHighlighted];
        weak(weakSelf)
        setWeak(cenBtn)
        [cenBtn addActionHandler:^(NSInteger tag) { //button添加动作
            if(weakSelf.CenterBtn){
                weakSelf.CenterBtn(weakSelf, weakcenBtn);
            }
        }];
        
    }
    return _cenBtn;
}
@end
