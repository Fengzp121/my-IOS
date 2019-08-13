//
//  verificationcodeViewController.m
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "VerificationView.h"

#import "verificationcodeViewController.h"
#import "ForgetPasswordViewController.h"
@interface verificationcodeViewController ()
{
    NSString *_phoneNum;
    NSString *_verifCODE;
}
@property (nonatomic,strong)VerificationView *verView;
@property (nonatomic,weak)UILabel *anewSend;
@property (nonatomic,weak)UIButton *nextBtn;
@end

@implementation verificationcodeViewController
-(instancetype)initWithPhone:(NSString *)PhoneNumber{
    self = [super init];
    if(self){
        _phoneNum = PhoneNumber;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    //接受VerView传来的text
    weak(weakSelf)
    weakSelf.verView.block = ^(NSString *text){
        NSLog(@"block-text:%@",text);
        self->_verifCODE = text;
    };
    NSLog(@"text = %@",_verifCODE);
}

-(void)setUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"验证码界面";
    [self nextBtn];
    [self anewSend];
}


-(void)nextBtnClick{
    
    if(_verifCODE.length == 6){
        //对验证码进行验证,两个参数，一个是手机号，一个是验证码。
        weak(weakSelf)
        [[FFdataEngine sharedInstance] VerificatCheckAPI:self phoneNum:_phoneNum verification:_verifCODE requesBlock:^(id data, int code, NSString *message) {
            NSLog(@"message:%@",[data mj_JSONString]);
            ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } errorBlock:^(NSError *error) {
            NSLog(@"验证失败");
        }];

    }

    else{
        NSLog(@"验证码不能为空");
    }

    
}

-(void)anewLabeltap:(UITapGestureRecognizer *)tap{
    NSLog(@"重新发送");
    //重新发送验证码请求
    
}

-(VerificationView *)verView{
    if(_verView == nil){
       _verView = [[VerificationView alloc] initWithFrame:CGRectMake(FFScreenWidth / 2 -(FFScreenWidth * 0.85 /2), 200, FFScreenWidth *0.85, 50)];
        _verView.maxLenght = 6;
        [_verView mq_verCodeViewWithMaxLenght];
        [self.view addSubview:_verView];

    }
    return _verView;
}

-(UILabel *)anewSend{
    if(_anewSend == nil){
        UILabel *anewSend=[[UILabel alloc] init];
        [self.view addSubview:anewSend];
        _anewSend = anewSend;
        anewSend.text = @"重新发送";
        anewSend.textColor = UIColor.grayColor;
        anewSend.textAlignment = NSTextAlignmentLeft;
        anewSend.font = [UIFont systemFontOfSize:10];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(anewLabeltap:)];
        [anewSend addGestureRecognizer:tap];
        anewSend.userInteractionEnabled = YES;
        [anewSend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(30);
            make.width.offset(100);
            make.top.mas_equalTo(self.verView.mas_bottom).offset(15);
            make.left.mas_equalTo(self.verView.mas_left);
        }];
    }
    return _anewSend;
}




-(UIButton *)nextBtn{
    if(_nextBtn == nil){
        UIButton *nextBtn = [[UIButton alloc] init];
        [self.view addSubview:nextBtn];
        _nextBtn = nextBtn;
        nextBtn.backgroundColor = UIColor.whiteColor;
        nextBtn.layer.borderWidth = 1;
        nextBtn.layer.cornerRadius = 5;
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchDown];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.verView.mas_bottom).offset(40);
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.4);
            make.height.offset(50);
        }];
    }
    return _nextBtn;
}
@end
