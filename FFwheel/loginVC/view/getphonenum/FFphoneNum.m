//
//  FFphoneNum.m
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFphoneNum.h"
@interface FFphoneNum()<UITextFieldDelegate>



@end

@implementation FFphoneNum

-(void)layoutSubviews{
    [super layoutSubviews];
    [self quNoField];
    [self phoneNumField];
}

-(NSArray<NSString *> *)getNUM{
    NSArray<NSString *> * arr =@[self.quNoField.text,self.phoneNumField.text];
//    if([NSString isNotEmpty:arr[0]] && [NSString isNotEmpty:arr[1]]){
//        if([NSString isrealMobile:arr[1]]){
//            return arr;
//        }
//        else{
//            NSLog(@"请输入正确的手机号");
//            return nil;
//        }
//    }
//    else{
//        NSLog(@"请输入完整的手机号");
//        return nil;
//    }
    return arr;
}

-(UITextField *)quNoField{
    if(_quNoField == nil){
        UITextField * quNoField = [[UITextField alloc] init];
        [self addSubview:quNoField];
        _quNoField = quNoField;
        quNoField.text = @"+86";
        quNoField.delegate = self;
        quNoField.textAlignment = NSTextAlignmentCenter;
        quNoField.keyboardType = UIKeyboardTypeNumberPad;
        quNoField.borderStyle = UITextBorderStyleLine;
        quNoField.layer.cornerRadius = 5;
        [quNoField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.offset(50);
        }];
    }
    return _quNoField;
}

-(UITextField *)phoneNumField{
    if(_phoneNumField == nil){
        UITextField *phoneNumField = [[UITextField alloc] init];
        [self addSubview:phoneNumField];
        _phoneNumField = phoneNumField;
        phoneNumField.placeholder = @"请输入手机号";
        phoneNumField.textAlignment = NSTextAlignmentLeft;
        phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
        phoneNumField.borderStyle = UITextBorderStyleLine;
        [phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.quNoField.mas_right).offset(1);
            make.right.top.bottom.offset(0);
        }];
    }
    return _phoneNumField;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    // text field 上实际字符长度
    NSInteger strLength = textField.text.length - range.length + string.length;
    return(strLength <= 4);
}

@end
