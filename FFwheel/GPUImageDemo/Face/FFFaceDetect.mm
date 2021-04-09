//
//  FFFaceDetect.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/8.
//  Copyright © 2021 ffzp. All rights reserved.
//

#include "stasm_lib.h"
#include <opencv2/face.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs/ios.h>
#include <opencv2/imgproc/imgproc.hpp>

#import "MGFacepp.h"
#import "MGFaceLicenseHandle.h"
#define kFaceppPointCount 106

#import <Vision/Vision.h>
#import <CoreML/CoreML.h>

#import "FFFaceDetect.h"
@interface FFFaceDetect()
@property (nonatomic, strong) MGFacepp *markManager;
@property (nonatomic, assign) BOOL kaiguan;
@end


@implementation FFFaceDetect

- (instancetype)init{
    if(self = [super init]){
        _sampleBufferSize = CGSizeMake(720, 1280);
        _faceDetectType = FFFaceDetectType_OPENCV;
        _kaiguan = NO; //默认关闭
    }
    return self;
}

+ (instancetype)defaultInstance{
    static FFFaceDetect *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FFFaceDetect alloc] init];
    });
    return instance;
}

-(void)start{
    self.kaiguan = YES;
}

-(void)stop{
    self.kaiguan = NO;
}


- (void)licenseFacepp{
    @weakify(self);
    [MGFaceLicenseHandle licenseForNetwokrFinish:^(bool License, NSDate *sdkDate) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (License) {
                NSLog(@"Face++授权成功");
                [self setupFacepp];
            } else {
                NSLog(@"Face++授权失败");
            }
        });
    }];
    
}

- (float *)detectWithSampleBuffer:(CMSampleBufferRef)sampleBuffer facePointCount:(int *)facePointCount isMirror:(BOOL)isMirror{
    if(!self.kaiguan) return nil;
    if(self.faceDetectType == FFFaceDetectType_OPENCV){
        return [self detectOpenCVWithSampleBuffer:sampleBuffer facePointCount:facePointCount isMirror:isMirror];
    }else if(self.faceDetectType == FFFaceDetectType_FACEPP){
        return [self detectFaceppWithSampleBuffer:sampleBuffer facePointCount:facePointCount isMirror:isMirror];
    }else if(self.faceDetectType == FFFaceDetectType_VISION){
        [self detectVisionWithSampleBuffer:sampleBuffer facePointCount:nil isMirror:NO];
    }
    return nil;
}

- (void)visionDetectWithSampleBuffer:(CMSampleBufferRef)sampleBuffer completHandler:(void (^)())completHandler{
    
}

#pragma mark - face++
- (float *)detectFaceppWithSampleBuffer:(CMSampleBufferRef)sampleBuffer facePointCount:(int *)facePointCount isMirror:(BOOL)isMirror{
    if(!self.markManager) return nil;
    MGImageData *imageData = [[MGImageData alloc] initWithSampleBuffer:sampleBuffer];
    [self.markManager beginDetectionFrame];
    NSArray *faceArray = [self.markManager detectWithImageData:imageData];
    
    NSInteger faceCount = [faceArray count];
    int singleFaceLen = 2 * kFaceppPointCount;
    int len = singleFaceLen * (int)faceCount;
    float *landmarks = (float *)malloc(len * sizeof(float));
    
    for (MGFaceInfo *faceInfo in faceArray) {
        NSInteger faceIndex = [faceArray indexOfObject:faceInfo];
        [self.markManager GetGetLandmark:faceInfo isSmooth:YES pointsNumber:kFaceppPointCount];
        [faceInfo.points enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL *stop) {
            float x = value.CGPointValue.y / self.sampleBufferSize.width;
            x = (isMirror ? x : (1 - x))  * 2 - 1;
            float y = value.CGPointValue.x / self.sampleBufferSize.height * 2 - 1;
            landmarks[singleFaceLen * faceIndex + idx * 2] = x;
            landmarks[singleFaceLen * faceIndex + idx * 2 + 1] = y;
        }];
    }
    [self.markManager endDetectionFrame];

    if (faceArray.count) {
        *facePointCount = kFaceppPointCount * (int)faceCount;
        return landmarks;
    } else {
        free(landmarks);
        return nil;
    }
}

- (void)setupFacepp {
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME
                                                          ofType:@""];
    NSData *modelData = [NSData dataWithContentsOfFile:modelPath];
    self.markManager = [[MGFacepp alloc] initWithModel:modelData faceppSetting:^(MGFaceppConfig *config) {
        config.detectionMode = MGFppDetectionModeTrackingRobust;
        config.pixelFormatType = PixelFormatTypeNV21;
        config.orientation = 90;
    }];
}

#pragma mark - openCV
- (float *)detectOpenCVWithSampleBuffer:(CMSampleBufferRef)sampleBuffer facePointCount:(int *)facePointCount isMirror:(BOOL)isMirror{
    cv::Mat cvImage = [self grayMatWithSampleBuffer:sampleBuffer];
    int resultWidth = 150;
    int resultHeight = resultWidth * 1.0 / cvImage.rows * cvImage.cols;
    cvImage = [self resizeMat:cvImage toWidth:resultHeight];
    cvImage = [self correctMat:cvImage isMirror:isMirror];
    const char *imageData = (const char *)cvImage.data;
    
    
    //人脸是否存在
    int foundface = 0;
    // stasm_NLANDMARKS 表示人脸关键点数
    int len = 2 * stasm_NLANDMARKS;
    float *landmarks = (float *)malloc(len * sizeof(float));
    //训练库地址
    const char *xmlPath = [[NSBundle mainBundle].bundlePath UTF8String];
    
    // 获取宽高
    int imgCols = cvImage.cols;
    int imgRows = cvImage.rows;
    
    
    int stasmAction = stasm_search_single(&foundface, landmarks, imageData, imgCols, imgRows, "", xmlPath);
    
    if(!stasmAction) printf("error in stasm_search_single: %s\n", stasm_lasterr());
    
    cvImage.release();
    
    //如果有人脸
    if(foundface){
        for (int index = 0; index < len; ++index) {
            if(index % 2 == 0){
                landmarks[index] = landmarks[index] / imgCols * 2 - 1;
            }else{
                landmarks[index] = landmarks[index] / imgRows * 2 - 1;
            }
        }
        *facePointCount = stasm_NLANDMARKS;
        return landmarks;
    }
    
    free(landmarks);
    return nil;
}

// 生成灰度图矩阵
- (cv::Mat)grayMatWithSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    OSType format = CVPixelBufferGetPixelFormatType(pixelBuffer);
    // 检查是否 YUV 编码
    if (format != kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
        NSLog(@"Only YUV is supported");
        return cv::Mat();
    }
    
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    void *baseaddress = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    CGFloat width = CVPixelBufferGetWidth(pixelBuffer);
    CGFloat colCount = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, 0);
    if (width != colCount) {
        width = colCount;
    }
    CGFloat height = CVPixelBufferGetHeight(pixelBuffer);
    // CV_8UC1 表示单通道矩阵，转换为单通道灰度图后，可以使识别的计算速度提高
    cv::Mat mat(height, width, CV_8UC1, baseaddress, 0);
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    return mat;
}

// 矩阵缩放
- (cv::Mat)resizeMat:(cv::Mat)mat toWidth:(CGFloat)width {
    CGFloat orginWidth = mat.cols;
    CGFloat orginHeight = mat.rows;
    int reCols = width;
    int reRows = (int)((CGFloat)reCols * orginHeight) / orginWidth;
    cv::Size reSize = cv::Size(reCols, reRows);
    resize(mat, mat, reSize);
    
    return mat;
}

// 矫正图像
- (cv::Mat)correctMat:(cv::Mat)mat isMirror:(BOOL)isMirror {
    if (!isMirror) {
        cv::flip(mat, mat, 0);  // > 0: 沿 y 轴翻转, 0: 沿 x 轴翻转, <0: x、y 轴同时翻转
    }
    // transpose 会旋转 90 度的同时，进行镜像变换，所以后置的时候反而需要先镜像一次
    cv::transpose(mat, mat);
    return mat;
}

#pragma mark - VISION
- (void)detectVisionWithSampleBuffer:(CMSampleBufferRef)sampleBuffer facePointCount:(int *)facePointCount isMirror:(BOOL)isMirror{
    if(@available(iOS 14, *)){
        VNImageRequestHandler *faceRequestHandler = [[VNImageRequestHandler alloc] initWithCMSampleBuffer:sampleBuffer options:@{}];
        VNImageBasedRequest *detectRequest = [[VNImageBasedRequest alloc] init];
        detectRequest = [[VNDetectFaceLandmarksRequest alloc] init];
        [faceRequestHandler performRequests:@[detectRequest] error:nil];
        
        NSLog(@"vision detect result:%@",[detectRequest results]);
        for(VNFaceObservation *observation in detectRequest.results){
            NSLog(@"vision detect point:%@",observation.landmarks.allPoints);
        }
    }

}

@end
