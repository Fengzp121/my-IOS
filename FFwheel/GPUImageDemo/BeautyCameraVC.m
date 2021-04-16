//
//  BeautyCameraVC.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/9.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "BeautyCameraVC.h"
#import <GPUImage/GPUImage.h>
#import "FFFaceDetect.h"

#import "VisionBeautifyFaceFilter.h"
#import "BeautifyFaceFilter.h"


#define FilterMinValue 0.00
#define ThinFaceMaxValue   0.05
#define BigEyeMaxValue 0.15

@interface BeautyCameraVC ()<GPUImageVideoCameraDelegate>
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;

@property (nonatomic, strong) UIButton *controlBtn;
@property (nonatomic, strong) UISlider *thinFaceSlider;
@property (nonatomic, strong) UISlider *bigEyeSlider;

@property (nonatomic, strong) VisionBeautifyFaceFilter *faceAndEyeFilter;
@property (nonatomic, strong) BeautifyFaceFilter *beautifyFilter;
@end

@implementation BeautyCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.delegate = self;
    self.videoCamera.horizontallyMirrorRearFacingCamera = YES;
    self.videoCamera.frameRate = 25;
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//    [self.videoCamera addAudioInputsAndOutputs];
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    self.filterView.center = self.view.center;
    [self.view addSubview:self.filterView];
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
    [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_VISION;
    self.faceAndEyeFilter = [[VisionBeautifyFaceFilter alloc] init];
    self.beautifyFilter   = [[BeautifyFaceFilter alloc] init];
    [self.videoCamera addTarget:self.faceAndEyeFilter];
    [self.videoCamera addTarget:self.beautifyFilter];
    [self.faceAndEyeFilter addTarget:self.filterView];
    [self.beautifyFilter addTarget:self.filterView];
    
    
    self.controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.controlBtn.backgroundColor = UIColor.whiteColor;
    [self.controlBtn setTitle:@"开启" forState:UIControlStateNormal];
    [self.controlBtn setTitle:@"关闭" forState:UIControlStateSelected];
    [self.controlBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.controlBtn addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.controlBtn];
    self.controlBtn.selected = NO;  //默认关闭
    [self.controlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.offset(80);
        make.height.offset(50);
        make.right.equalTo(self.view).offset(-10);
    }];

    
    UILabel *title1 = [[UILabel alloc] init];
    title1.text = @"瘦脸";
    [self.view addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-(SafeAreaBottom + 50));
        make.left.equalTo(self.view).offset(10);
        make.width.offset(50);
        make.height.offset(20);
    }];
    
    self.thinFaceSlider = [[UISlider alloc] init];
    [self.thinFaceSlider addTarget:self action:@selector(moveThinFaceSlider:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:self.thinFaceSlider];
    [self.thinFaceSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title1);
        make.left.equalTo(title1.mas_right).offset(10);
        make.right.equalTo(self.controlBtn.mas_left).offset(-10);
        make.height.offset(25);
    }];
    
    UILabel *title2 = [[UILabel alloc] init];
    title2.text = @"大眼";
    [self.view addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-(SafeAreaBottom + 25));
        make.left.equalTo(self.view).offset(10);
        make.width.offset(50);
        make.height.offset(20);
    }];
    
    self.bigEyeSlider = [[UISlider alloc] init];
    [self.bigEyeSlider addTarget:self action:@selector(moveBigEyeSlider:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:self.bigEyeSlider];
    [self.bigEyeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title2);
        make.left.equalTo(title2.mas_right).offset(10);
        make.right.equalTo(self.controlBtn.mas_left).offset(-10);
        make.height.offset(25);
    }];
    
    

}

#pragma mark - button action
- (void)switchButtonAction:(UIButton *)sender{
    [self.videoCamera removeAllTargets];
    if(sender.selected){
        [self.videoCamera addTarget:self.filterView];
        [[FFFaceDetect defaultInstance] stop];
    }else{
        [self.videoCamera addTarget:self.faceAndEyeFilter];
        [self.videoCamera addTarget:self.beautifyFilter];
        [self.faceAndEyeFilter addTarget:self.filterView];
        [self.beautifyFilter addTarget:self.filterView];
        [[FFFaceDetect defaultInstance] start];
    }
    sender.selected = !sender.isSelected;
}

// 这里添加瘦脸和大眼的滤镜的slider控制器
#pragma mark - slider action
-(void)moveThinFaceSlider:(id)sender{
    CGFloat f = ((UISlider *)sender).value;
    self.faceAndEyeFilter.thinFaceDelta = (ThinFaceMaxValue - FilterMinValue) * f + FilterMinValue;
}

-(void)moveBigEyeSlider:(id)sender{
    CGFloat f = ((UISlider *)sender).value;
    self.faceAndEyeFilter.bigEyeDelta = (BigEyeMaxValue - FilterMinValue) * f + FilterMinValue;
}

#pragma mark - GPUCamera Delegate
-(void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    int a = 0;
    [[FFFaceDetect defaultInstance] detectWithSampleBuffer:sampleBuffer facePointCount:&a isMirror:YES];
    NSArray *landmarks = [FFFaceDetect defaultInstance].landmarks;
    if(landmarks.count){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int i=0; i< landmarks.count; i++) {
                    UIView *pointview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 3)];
                    pointview.backgroundColor = [UIColor yellowColor];
                    NSValue *value = landmarks[i];
                    CGPoint point = [value CGPointValue];
                    pointview.center = CGPointMake(point.x * self.filterView.frame.size.width, point.y * self.filterView.frame.size.height);
                    [self.filterView addSubview:pointview];
                    
                    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 24, 12)];
                    indexLabel.font = [UIFont systemFontOfSize:8.0];
                    indexLabel.textColor = [UIColor orangeColor];
                    indexLabel.center = CGPointMake(point.x * self.filterView.frame.size.width, point.y * self.filterView.frame.size.height + 5);
                    indexLabel.text = [NSString stringWithFormat:@"%d",i];
                    [self.filterView addSubview:indexLabel];
                }
                
            });
        });
    }
}
@end
