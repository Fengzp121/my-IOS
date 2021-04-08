//
//  FFNavigationViewController.m
//  videoEditTest
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFNavigationViewController.h"
#import "HelloWorldVC.h"
@interface FFNavigationViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong)UIButton *navBackButton;
@end

@implementation FFNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count > 0 && ![viewController isKindOfClass:[HelloWorldVC class]]){
        UIBarButtonItem *navtivcSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        navtivcSpace.width = -5;
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:self.navBackButton];
        viewController.navigationItem.leftBarButtonItems = @[navtivcSpace,backButton];
    }
    [super pushViewController:viewController animated:animated];
}

-(UIButton *)navBackButton{
    if(_navBackButton == nil){
        _navBackButton = [[UIButton alloc ] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [_navBackButton setTitle:@"back" forState:UIControlStateNormal];
        _navBackButton.backgroundColor = UIColor.redColor;
        _navBackButton.layer.cornerRadius = 5;
        [_navBackButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBackButton;
}

-(void)back{
    [self popViewControllerAnimated:YES];
}
@end
