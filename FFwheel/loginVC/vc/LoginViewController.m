//
//  LoginViewController.m
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "getPhoneNumViewController.h"
#import "LoginingViewController.h"
@interface LoginViewController ()

@property (nonatomic,weak)UIButton *loginBtn;

@property (nonatomic,weak)UIButton *registBtn;

@property (nonatomic,weak)UIImageView *logoImageView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    self.view.backgroundColor = UIColor.whiteColor;
    [self loginBtn];
    [self registBtn];
    [self logoImageView];
}

#pragma mark -----Btn action
-(void)loginBtnClick{
    NSLog(@"loginBtnClick");
    LoginingViewController *vc = [[LoginingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)registBtnClick{
    NSLog(@"registBtnClick");
    getPhoneNumViewController *vc = [[getPhoneNumViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----lazy load


-(UIButton *)loginBtn{
    if(_loginBtn == nil){
        UIButton *loginBtn = [[UIButton alloc] init];
        [self.view addSubview:loginBtn];
        _loginBtn = loginBtn;
        loginBtn.backgroundColor = UIColor.whiteColor;
        loginBtn.layer.borderWidth = 1;
        loginBtn.layer.cornerRadius = 5;
        //loginBtn.titleLabel.text = @"登录";
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchDown];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.4);
            make.height.offset(60);
            make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(200);
        }];
    }
    return _loginBtn;
}

-(UIButton *)registBtn{
    if(_registBtn == nil){
        UIButton *registBtn = [[UIButton alloc] init];
        [self.view addSubview:registBtn];
        _registBtn = registBtn;
        registBtn.backgroundColor = UIColor.whiteColor;
        registBtn.layer.borderWidth = 1;
        registBtn.layer.cornerRadius = 5;
        //loginBtn.titleLabel.text = @"登录";
        [registBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [registBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        registBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchDown];
        [registBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.4);
            make.height.offset(60);
            make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(10);
        }];
    }
    return _loginBtn;
}

-(UIImageView *)logoImageView{
    if(_logoImageView == nil){
        UIImageView *logoImageView = [[UIImageView alloc] init];
        [self.view addSubview:logoImageView];
        _logoImageView = logoImageView;
        logoImageView.backgroundColor = UIColor.redColor;
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(100);
            make.centerX.mas_equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _logoImageView;
}

@end
