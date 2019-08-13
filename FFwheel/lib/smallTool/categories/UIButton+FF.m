//
//  UIButton+FF.m
//  FFwheel
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UIButton+FF.h"

static const void *UIButtonBlockKey = &UIButtonBlockKey;
@implementation UIButton(FF)

-(void)addActionHandler:(ClickBtnBlock)clickBtnBlock{
    objc_setAssociatedObject(self, UIButtonBlockKey, clickBtnBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(ClickAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ClickAction:(UIButton *)button{
    ClickBtnBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if(block){
        block(button.tag);
    }
}
@end
