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
#import "ChangeFaceFilter.h"

#define FilterMinValue 0.00
#define ThinFaceMaxValue   0.05
#define BigEyeMaxValue 0.15

@interface BeautyCameraVC ()<GPUImageVideoCameraDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *filterTitle;           //当前选择的滤镜的标题
@property (nonatomic, strong) UIScrollView *scrollView; //滑动选择美颜效果的
@property (nonatomic, strong) UIButton *controlBtn;     //现在是美颜开关的按钮，迟点会换成前后摄像头切换的按钮
@property (nonatomic, strong) UISlider *theSlider; //现在只需要一个滑动

@property (nonatomic, copy) NSArray *dataSrouce;      //美颜的数据源

@property (nonatomic, strong) VisionBeautifyFaceFilter *faceAndEyeFilter;
@property (nonatomic, strong) BeautifyFaceFilter *beautifyFilter;
@property (nonatomic, strong) ChangeFaceFilter *changeFilter;
@end

@implementation BeautyCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSrouce = @[@"瘦脸",@"大眼",@"美白",@"缩放",@"灵魂",@"震动",@"大灯",@"毛刺",@"眩晕"];
    [self buildUI];
    [self settingCamera];
    [self createFilters];
}

-(void)buildUI{
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.delegate = self;
    self.videoCamera.horizontallyMirrorRearFacingCamera = YES;
    self.videoCamera.frameRate = 25;
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    self.filterView.center = self.view.center;
    [self.view addSubview:self.filterView];
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
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

    self.filterTitle = [[UILabel alloc] init];
    self.filterTitle.textColor = UIColor.whiteColor;
    self.filterTitle.text = @"瘦脸";              //默认廋脸
    [self.view addSubview:self.filterTitle];
    [self.filterTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-(SafeAreaBottom + 50));
        make.left.equalTo(self.view).offset(10);
        make.width.offset(50);
        make.height.offset(20);
    }];
    
    self.theSlider = [[UISlider alloc] init];
    [self.theSlider addTarget:self action:@selector(moveTheSlider:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:self.theSlider];
    [self.theSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.filterTitle);
        make.left.equalTo(self.filterTitle.mas_right).offset(10);
        make.right.equalTo(self.controlBtn.mas_left).offset(-10);
        make.height.offset(25);
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:NSClassFromString(@"UICollectionViewCell") forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.controlBtn.mas_left).offset(-10);
        make.bottom.equalTo(self.view).offset(-SafeAreaBottom);
        make.height.offset(45);
    }];
}

-(void)settingCamera{
    [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_FACEPP;
    self.faceAndEyeFilter = [[VisionBeautifyFaceFilter alloc] init];
    self.beautifyFilter   = [[BeautifyFaceFilter alloc] init];
    [self.videoCamera addTarget:self.faceAndEyeFilter];
    [self.videoCamera addTarget:self.beautifyFilter];
    [self.faceAndEyeFilter addTarget:self.filterView];
    [self.beautifyFilter addTarget:self.filterView];
}

-(void)createFilters{
    self.
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
-(void)moveTheSlider:(id)sender{
    //要识别当前数据源是什么类型的滤镜，然后再调整滤镜的参数
    CGFloat f = ((UISlider *)sender).value;
    self.faceAndEyeFilter.thinFaceDelta = (ThinFaceMaxValue - FilterMinValue) * f + FilterMinValue;
}

#pragma mark - CollectionView Delegate/DataSrouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSrouce.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.dataSrouce[indexPath.item];
    titleLabel.textColor = UIColor.whiteColor;
    [cell.contentView addSubview:titleLabel];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    self.filterTitle.text = self.dataSrouce[indexPath.item];
    //切换slider
}

#pragma mark -  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 35);
}
//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}



#pragma mark - GPUCamera Delegate
-(void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    //只有开启瘦脸和大眼之类的脸部特效才需要启用这个来读取。
    int facePointCount = 0;
    float* lamdMarks = [[FFFaceDetect defaultInstance] detectWithSampleBuffer:sampleBuffer facePointCount:&facePointCount isMirror:YES];
   
}
@end
