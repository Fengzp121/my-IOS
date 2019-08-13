//
//  ForgetPasswordViewController.m
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LoginingViewController.h"
@interface ForgetPasswordViewController ()
@property (nonatomic,weak)UITextField *passwordField1;

@property (nonatomic,weak)UITextField *passwordField2;

@property (nonatomic,weak)UIButton *nextBtn;


@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"重置密码界面";
    [self setUI];
}

-(void)setUI{
    [self passwordField1];
    [self passwordField2];
    [self nextBtn];
}

-(BOOL)checkNavigationIsForgetVC{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    for(UIViewController *vc in arr){
        if([vc isKindOfClass:[LoginingViewController class]]){
            return YES;
        }
    }
    return NO;
}

-(void)nextBtnClick{
    if([NSString isNotEmpty:self.passwordField1.text] && [NSString isNotEmpty:self.passwordField2.text]){
        if(self.passwordField1.text == self.passwordField2.text){
            if([self checkNavigationIsForgetVC]){
                NSLog(@"忘了密码接口");
            }
            else{
                NSLog(@"注册接口");
            }
        }
        else{
            NSLog(@"两个密码不一样");
        }
    }
    else{
        NSLog(@"密码不能为空");
    }
}


-(UITextField *)passwordField1{
    if(_passwordField1 == nil){
        UITextField *passwordField1 = [[UITextField alloc] init];
        [self.view addSubview:passwordField1];
        _passwordField1 = passwordField1;
        passwordField1.placeholder = @"请输密码";
        passwordField1.textAlignment = NSTextAlignmentLeft;
        passwordField1.keyboardType = UIKeyboardTypeDefault;
        passwordField1.borderStyle = UITextBorderStyleLine;
        [passwordField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(100);
            make.width.offset(FFScreenWidth * 0.8);
            make.height.offset(60);
            make.centerX.mas_equalTo(self.view);
        }];
    }
    return _passwordField1;
}

-(UITextField *)passwordField2{
    if(_passwordField2 == nil){
        UITextField *passwordField2 = [[UITextField alloc] init];
        [self.view addSubview:passwordField2];
        _passwordField2 = passwordField2;
        passwordField2.placeholder = @"再次输入密码";
        passwordField2.textAlignment = NSTextAlignmentLeft;
        passwordField2.keyboardType = UIKeyboardTypeDefault;
        passwordField2.borderStyle = UITextBorderStyleLine;
        [passwordField2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordField1.mas_bottom).offset(10);
            make.width.offset(FFScreenWidth * 0.8);
            make.height.offset(60);
            make.centerX.mas_equalTo(self.view);
        }];
    }
    return _passwordField2;
}

-(UIButton *)nextBtn{
    if(_nextBtn == nil){
        UIButton *nextBtn = [[UIButton alloc] init];
        [self.view addSubview:nextBtn];
        _nextBtn = nextBtn;
        nextBtn.backgroundColor = UIColor.whiteColor;
        nextBtn.layer.borderWidth = 1;
        nextBtn.layer.cornerRadius = 5;
        [nextBtn setTitle:@"确认" forState:UIControlStateNormal];
        [nextBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchDown];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.4);
            make.height.offset(50);
            make.top.mas_equalTo(self.passwordField2.mas_bottom).offset(100);
        }];
    }
    return _nextBtn;
}
@end
