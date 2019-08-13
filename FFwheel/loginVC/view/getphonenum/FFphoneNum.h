//
//  FFphoneNum.h
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FFphoneNum : UIView

@property (weak,nonatomic)UITextField *quNoField;

@property (weak,nonatomic)UITextField *phoneNumField;
-(NSArray<NSString *> *)getNUM;

@end


