//
//  LoginingViewController.m
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginingViewController.h"
#import "FFphoneNum.h"
#import "getPhoneNumViewController.h"
@interface LoginingViewController ()

@property (nonatomic,weak)FFphoneNum *getNumView;

@property (nonatomic,weak)UITextField *passwordField;

@property (nonatomic,weak)UILabel *forgotlabel;

@property (nonatomic,weak)UIButton *nextBtn;

@end

@implementation LoginingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setUI];
    self.title = @"登录界面";
    NSLog(@"git test");
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
}

-(void)setUI{
    [self getNumView];
    [self passwordField];
    [self forgotlabel];
    [self nextBtn];
}

-(void)nextBtnClick{
    if([NSString isNotEmpty:self.getNumView.getNUM[0]] && [NSString isNotEmpty:self.getNumView.getNUM[1]]){
        if([NSString isrealMobile:self.getNumView.getNUM[1]]){
            if([NSString isNotEmpty:self.passwordField.text]){
                NSLog(@"登录接口");
                [[FFdataEngine sharedInstance]LoginApi:self phoneNum:@"zhangsan" password:@"788ecd7a891c79403cfe0130ca08cdd4" requesBlock:^(id data, int code, NSString *message) {
                    if(code == CorrectCode){
                        NSString *str = [data mj_JSONString];
                        NSLog(@"data-to-str:%@",str);
                    }
                    else{
                        NSLog(@"请求失败2");
                    }
                } errorBlock:^(NSError *error) {
                    NSLog(@"login------error:%@",error);
                    NSLog(@"请求失败");
                    
                }];
            }
            else{
                NSLog(@"密码不能为空");
            }
        }
        else{
            NSLog(@"请输入正确的手机号");
        }
    }
    else{
        NSLog(@"请输入完整的手机号");
    }
    
    
}

-(void)forgotLabeltap:(UITapGestureRecognizer *)tap{
    NSLog(@"忘了密码忘了密码");
    getPhoneNumViewController *vc = [[getPhoneNumViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(FFphoneNum *)getNumView{
    if(_getNumView == nil){
        FFphoneNum *getNumView = [[FFphoneNum alloc] init];
        [self.view addSubview:getNumView];
        _getNumView = getNumView;
        [getNumView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(200);
            make.width.offset(FFScreenWidth * 0.8);
            make.height.offset(60);
            make.centerX.mas_equalTo(self.view);
        }];
    }
    return _getNumView;
}

-(UITextField *)passwordField{
    if(_passwordField == nil){
        UITextField *passwordField = [[UITextField alloc] init];
        [self.view addSubview:passwordField];
        _passwordField = passwordField;
        passwordField.placeholder = @"请输密码";
        passwordField.textAlignment = NSTextAlignmentLeft;
        passwordField.keyboardType = UIKeyboardTypeDefault;
        passwordField.borderStyle = UITextBorderStyleLine;
        passwordField.secureTextEntry = YES;
        [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.getNumView.mas_bottom).offset(10);
            make.width.offset(FFScreenWidth * 0.8);
            make.height.offset(60);
            make.centerX.mas_equalTo(self.view);
        }];
    }
    return _passwordField;
}

-(UILabel *)forgotlabel{
    if(_forgotlabel == nil){
        UILabel *forgotlabel=[[UILabel alloc] init];
        [self.view addSubview:forgotlabel];
        _forgotlabel = forgotlabel;
        forgotlabel.text = @"忘了密码";
        forgotlabel.textColor = UIColor.grayColor;
        forgotlabel.textAlignment = NSTextAlignmentRight;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgotLabeltap:)];
        [forgotlabel addGestureRecognizer:tap];
        forgotlabel.userInteractionEnabled = YES;
        [forgotlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(30);
            make.width.offset(100);
            make.top.mas_equalTo(self.passwordField.mas_bottom).offset(10);
            make.right.mas_equalTo(self.passwordField.mas_right);
        }];
    }
    return _forgotlabel;
}

-(UIButton *)nextBtn{
    if(_nextBtn == nil){
        UIButton *nextBtn = [[UIButton alloc] init];
        [self.view addSubview:nextBtn];
        _nextBtn = nextBtn;
        nextBtn.backgroundColor = UIColor.whiteColor;
        nextBtn.layer.borderWidth = 1;
        nextBtn.layer.cornerRadius = 5;
        [nextBtn setTitle:@"确认登录" forState:UIControlStateNormal];
        [nextBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchDown];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.4);
            make.height.offset(50);
            make.top.mas_equalTo(self.passwordField.mas_bottom).offset(100);
        }];
    }
    return _nextBtn;
}
@end
