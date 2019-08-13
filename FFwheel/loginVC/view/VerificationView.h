//
//  VerificationView.h
//  FFwheel
//
//  Created by ffzp on 2019/1/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TextViewBlock)(NSString *text);
@interface VerificationView : UIView

 
@property (nonatomic, copy) TextViewBlock block;

/*验证码的最大长度*/
@property (nonatomic, assign) NSInteger maxLenght;

/*未选中下的view的borderColor*/
@property (nonatomic, strong) UIColor *viewColor;

/*选中下的view的borderColor*/
@property (nonatomic, strong) UIColor *viewColorHL;

-(void)mq_verCodeViewWithMaxLenght;
@end

NS_ASSUME_NONNULL_END
