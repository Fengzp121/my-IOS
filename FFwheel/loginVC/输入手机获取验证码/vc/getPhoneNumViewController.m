//
//  getPhoneNumViewController.m
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "getPhoneNumViewController.h"
#import "FFphoneNum.h"
#import "verificationcodeViewController.h"

@interface getPhoneNumViewController ()
@property (nonatomic,weak)FFphoneNum *getNumView;

@property (nonatomic,weak)UIButton *nextBtn;
@end

@implementation getPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.title = @"获取手机号界面";
    
}

-(void)setUI{
    self.view.backgroundColor = UIColor.whiteColor;
    [self getNumView];
    [self nextBtn];
}

-(void)nextBtnClick{
    if([NSString isNotEmpty:self.getNumView.getNUM[0]] && [NSString isNotEmpty:self.getNumView.getNUM[1]]){
        if([NSString isrealMobile:self.getNumView.getNUM[1]]){
            
                NSLog(@"获取验证码接口");
    
        }
        else{
            NSLog(@"请输入正确的手机号");
        }
    }
    else{
        NSLog(@"请输入完整的手机号");
    }
    //self.getNumView.getNUM[1]
    verificationcodeViewController *vc = [[verificationcodeViewController alloc] initWithPhone:self.getNumView.getNUM[1]];
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
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.4);
            make.height.offset(50);
            make.top.mas_equalTo(self.getNumView.mas_bottom).offset(100);
        }];
    }
    return _nextBtn;
}
@end
