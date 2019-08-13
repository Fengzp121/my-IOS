//
//  UIButton+FF.h
//  FFwheel
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBtnBlock)(NSInteger tag);

@interface UIButton(FF)

-(void)addActionHandler:(ClickBtnBlock)clickBtnBlock;


@end

 
