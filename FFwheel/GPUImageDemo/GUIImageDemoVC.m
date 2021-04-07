//
//  GUIImageDemoVC.m
//  FFwheel
//
//  Created by ffzp on 2021/3/30.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "GUIImageDemoVC.h"

#import <GPUImage/GPUImage.h>
#import "BeautifyFaceFilter.h"

@interface GUIImageDemoVC ()
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, strong) UIButton *beautifyButton;
@end

@implementation GUIImageDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//    self.videoCamera.horizontallyMirrorRearFacingCamera = YES;
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.filterView.center = self.view.center;
    
    [self.view addSubview:self.filterView];
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
    self.beautifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.beautifyButton.backgroundColor = UIColor.whiteColor;
    [self.beautifyButton setTitle:@"开启" forState:UIControlStateNormal];
    [self.beautifyButton setTitle:@"关闭" forState:UIControlStateSelected];
    [self.beautifyButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.beautifyButton addTarget:self action:@selector(beautifyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.beautifyButton];
    [self.beautifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.width.offset(100);
        make.height.offset(50);
        make.centerX.equalTo(self.view);
    }];
}


- (void)beautifyButtonAction:(UIButton *)sender{
    if(sender.selected){
        sender.selected = NO;
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:self.filterView];
    }else{
        sender.selected = YES;
        [self.videoCamera removeAllTargets];
        BeautifyFaceFilter *filter = [[BeautifyFaceFilter alloc] init];
        [self.videoCamera addTarget:filter];
        [filter addTarget:self.filterView];
    }
}

@end
