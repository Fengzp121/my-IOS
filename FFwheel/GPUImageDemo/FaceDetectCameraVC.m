//
//  FaceDetectCameraVC.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/9.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "FaceDetectCameraVC.h"
#import <GPUImage/GPUImage.h>
#import "FFFaceDetect.h"
#import "FaceDetectPointFilter.h"

@interface FaceDetectCameraVC ()<GPUImageVideoCameraDelegate>
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, strong) UIButton *controlBtn;
@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) UISwitch *cameraTypeBtn;
@end

@implementation FaceDetectCameraVC
{
    FaceDetectPointFilter *faceFilter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //授权face
    [[FFFaceDetect defaultInstance] licenseFacepp];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.delegate = self;
//    self.videoCamera.horizontallyMirrorRearFacingCamera = YES;
    self.videoCamera.frameRate = 25;
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    self.filterView.center = self.view.center;
    
    
    [self.view addSubview:self.filterView];
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
    
    faceFilter = [[FaceDetectPointFilter alloc] init];
    [self.videoCamera addTarget:faceFilter];
    [faceFilter addTarget:self.filterView];
    
    self.controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.controlBtn.backgroundColor = UIColor.whiteColor;
    [self.controlBtn setTitle:@"开启" forState:UIControlStateNormal];
    [self.controlBtn setTitle:@"关闭" forState:UIControlStateSelected];
    [self.controlBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.controlBtn addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.controlBtn];
    self.controlBtn.selected = NO;  //默认关闭
    [self.controlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.width.offset(100);
        make.height.offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.typeBtn.backgroundColor = UIColor.whiteColor;
    [self.typeBtn setTitle:@"选择类型" forState:UIControlStateNormal];
    [self.typeBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.typeBtn addTarget:self action:@selector(selectDetectType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.width.offset(100);
        make.height.offset(50);
        make.left.equalTo(self.controlBtn.mas_right).offset(20);
    }];
    
    self.cameraTypeBtn = [[UISwitch alloc] init];
    [self.view addSubview:self.cameraTypeBtn];
    [self.cameraTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.centerX.equalTo(self.view);
    }];
    [self.cameraTypeBtn addTarget:self action:@selector(cameraTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)switchButtonAction:(UIButton *)sender{
    if(sender.selected){
        sender.selected = NO;
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:self.filterView];
        [[FFFaceDetect defaultInstance] stop];
    }else{
        sender.selected = YES;
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:faceFilter];
        [faceFilter addTarget:self.filterView];
        [[FFFaceDetect defaultInstance] start];
    }
}

- (void)cameraTypeBtnAction:(UISwitch *)sender{
    [self.videoCamera rotateCamera];
//    self.videoCamera.cameraPosition = sender.on ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
}


- (void)selectDetectType:(UIButton *)sender{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择检测算法" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"Face++" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_FACEPP;
    }];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"OpenCV+Stasm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_OPENCV;
    }];
    UIAlertAction *actionThree = [UIAlertAction actionWithTitle:@"Vision" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_VISION;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消选择" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:actionOne];
    [alertVC addAction:actionTwo];
    [alertVC addAction:actionThree];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Camera Delegate
-(void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    int facePointCount = 0;
    float * facePoint = [[FFFaceDetect defaultInstance] detectWithSampleBuffer:sampleBuffer facePointCount:&facePointCount isMirror:NO];
    faceFilter.facesPoints = facePoint;
    faceFilter.facesPointCount = facePointCount;
    
    
}

@end
