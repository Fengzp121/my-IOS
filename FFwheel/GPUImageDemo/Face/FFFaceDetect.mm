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
#define kVisionPointCount 76

#import <Vision/Vision.h>
#import <CoreML/CoreML.h>

#import "FFFaceDetect.h"

typedef void(^CompletionHandler) (VNRequest *request, NSError * _Nullable error);
typedef void(^detectImageHandler) (id data);

@interface FFFaceDetect()
@property (nonatomic, strong) MGFacepp *markManager;
@property (nonatomic, assign) BOOL kaiguan;
@end

@interface DSDetectFaceData : NSObject

@property (nonatomic, strong)VNFaceObservation * _Nullable observation;

@property (nonatomic, strong)NSMutableArray * _Nullable allPoints;

// 脸部轮廊
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nonnull faceContour;
// 左眼，右眼
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable leftEye;
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable rightEye;
// 鼻子，鼻嵴
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable nose;
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable noseCrest;
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable medianLine;
// 外唇，内唇
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable outerLips;
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable innerLips;
// 左眉毛，右眉毛
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable leftEyebrow;
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable rightEyebrow;
// 左瞳,右瞳
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable leftPupil;
@property (nonatomic, strong) VNFaceLandmarkRegion2D * _Nullable rightPupil;

@end


@interface DSDetectData : NSObject

// 所有识别的人脸坐标
@property (nonatomic, strong)NSMutableArray * _Nonnull faceAllRect;

// 所有识别的文本坐标
@property (nonatomic, strong)NSMutableArray * _Nonnull textAllRect;

// 所有识别的特征points
@property (nonatomic, strong)NSMutableArray * _Nonnull facePoints;
@end

@implementation DSDetectData

- (NSMutableArray *)textAllRect{
    if (!_textAllRect) {
        _textAllRect = @[].mutableCopy;
    }
    return _textAllRect;
}
- (NSMutableArray *)faceAllRect
{
    if (!_faceAllRect) {
        _faceAllRect = @[].mutableCopy;
    }
    return _faceAllRect;
}

- (NSMutableArray *)facePoints{
    if (!_facePoints) {
        _facePoints = @[].mutableCopy;
    }
    return _facePoints;
}
@end

@implementation DSDetectFaceData
- (NSMutableArray *)allPoints
{
    if (!_allPoints) {
        _allPoints = @[].mutableCopy;
    }
    return _allPoints;
}
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
        return [self detectVisionWithSampleBuffer:sampleBuffer facePointCount:facePointCount isMirror:isMirror];
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
    
    //他这个支持多脸，所以会有这个faceInfo和faceIndex
    for (MGFaceInfo *faceInfo in faceArray) {
        NSInteger faceIndex = [faceArray indexOfObject:faceInfo];
//        NSLog(@"facepp faceIndex:%li - faceInfo:%@", faceIndex,faceInfo);
        [self.markManager GetGetLandmark:faceInfo isSmooth:YES pointsNumber:kFaceppPointCount];
        [faceInfo.points enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL *stop) {
            printf("facepp x:%f y:%f",value.CGPointValue.x,value.CGPointValue.y);
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
    
    if(!stasmAction) stasm_lasterr();// printf("error in stasm_search_single: %s\n", stasm_lasterr());
    
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
//        NSLog(@"Only YUV is supported");
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
- (float *)detectVisionWithSampleBuffer:(CMSampleBufferRef)sampleBuffer facePointCount:(int *)facePointCount isMirror:(BOOL)isMirror{
    if(@available(iOS 14, *)){
        VNImageRequestHandler *faceRequestHandler = [[VNImageRequestHandler alloc] initWithCMSampleBuffer:sampleBuffer options:@{}];
        VNImageBasedRequest *detectRequest = [[VNImageBasedRequest alloc] init];
        detectRequest = [[VNDetectFaceLandmarksRequest alloc] init];
        [faceRequestHandler performRequests:@[detectRequest] error:nil];
        
//        NSLog(@"vision detect result:%@",[detectRequest results]);
        int faceCount = (int)detectRequest.results.count;
        int len = faceCount * 2 * kVisionPointCount;
        float *landmarks = (float *)malloc(len * sizeof(float));
        for(VNFaceObservation *observation in detectRequest.results){
            NSInteger faceIndex = [detectRequest.results indexOfObject:observation];
//            [observation.landmarks.allPoints.normalizedPoints ]
//            NSLog(@"vision detect point:%@",observation.landmarks.allPoints);
            //所以这里计算的公式可以。
            for (int i = 0 ; i < observation.landmarks.allPoints.pointCount; i++) {
                //这里只是转换了正常坐标,还是有点问题
                CGPoint point = observation.landmarks.allPoints.normalizedPoints[i];
                CGFloat rectWidth = self.sampleBufferSize.width * observation.boundingBox.size.width;
                CGFloat rectHeight = self.sampleBufferSize.height * observation.boundingBox.size.height;
                float frameX = point.x * rectWidth + observation.boundingBox.origin.x * self.sampleBufferSize.width;
                float frameY = observation.boundingBox.origin.y * self.sampleBufferSize.height + point.y * rectHeight;
                printf("vision x:%f y:%f",frameX,frameY);
                //这里上面的还要进行一次facepp那样子的计算才可以
                float x = frameY / self.sampleBufferSize.width;
                x = (isMirror ? x : (1 - x))  * 2 - 1;
                float y = frameX / self.sampleBufferSize.height * 2 - 1;

                landmarks[2* kVisionPointCount * faceIndex + i * 2] = x;
                landmarks[2* kVisionPointCount * faceIndex + i * 2 + 1] = y;
            }
        }
        if(detectRequest.results.count){
            *facePointCount = kVisionPointCount * faceCount;
            return landmarks;
        }else{
            free(landmarks);
            return nil;
        }
        
    }
    return nil;
}
//---------------------------------------

+ (void)detectImageWithpixelBuffer:(CVPixelBufferRef)pixelBuffer complete:(detectImageHandler _Nullable )complete
{
    // 创建处理requestHandler
    VNImageRequestHandler *detectFaceRequestHandler = [[VNImageRequestHandler alloc]initWithCVPixelBuffer:pixelBuffer orientation:kCGImagePropertyOrientationLeftMirrored options:@{}];
    // 创建BaseRequest
    VNImageBasedRequest *detectRequest = [[VNImageBasedRequest alloc]init];
    
    // 设置回调
    CompletionHandler completionHandler = ^(VNRequest *request, NSError * _Nullable error) {
        NSArray *observations = request.results;
        //[self handleImageWithType:type image:nil observations:observations complete:complete];
        [self faceRectangles:observations image:nil complete:complete];
    };
    detectRequest = [[VNDetectFaceLandmarksRequest alloc]initWithCompletionHandler:completionHandler];
    // 发送识别请求
    [detectFaceRequestHandler performRequests:@[detectRequest] error:nil];
}

// 处理人脸识别回调
+ (void)faceRectangles:(NSArray *)observations image:(UIImage *_Nullable)image complete:(detectImageHandler _Nullable )complete{
    
    NSMutableArray *tempArray = @[].mutableCopy;
    
    DSDetectData *detectFaceData = [[DSDetectData alloc]init];
    for (VNFaceObservation *observation  in observations) {
        NSValue *ractValue = [NSValue valueWithCGRect:[self convertRect:observation.boundingBox imageSize:image.size]];
        [tempArray addObject:ractValue];
    }
    
    detectFaceData.faceAllRect = tempArray;
    if (complete) {
        complete(detectFaceData);
    }
}

+ (CGRect)convertRect:(CGRect)oldRect imageSize:(CGSize)imageSize{
    
    CGFloat w = oldRect.size.width * imageSize.width;
    CGFloat h = oldRect.size.height * imageSize.height;
    CGFloat x = oldRect.origin.x * imageSize.width;
    CGFloat y = imageSize.height - (oldRect.origin.y * imageSize.height) - h;
    return CGRectMake(x, y, w, h);
}


- (void)handleFaceData:(DSDetectFaceData *)faceData{
//
//    while (self.gpuImageView.subviews.count) {
//        [self.gpuImageView.subviews.lastObject removeFromSuperview];
//    }
    // 遍历位置信息
    CGFloat faceRectWidth = FFScreenWidth * faceData.observation.boundingBox.size.width;
    CGFloat faceRectHeight = FFScreenHeight * faceData.observation.boundingBox.size.height;
    CGFloat faceRectX = faceData.observation.boundingBox.origin.x * FFScreenWidth;
    // Y默认的位置是左下角
    CGFloat faceRectY = faceData.observation.boundingBox.origin.y * FFScreenHeight;
    
    __block int index = 0;
    NSMutableArray *array = [NSMutableArray array];
    [faceData.allPoints enumerateObjectsUsingBlock:^(VNFaceLandmarkRegion2D *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // VNFaceLandmarkRegion2D *obj 是一个对象. 表示当前的一个部位
        // 遍历当前部分所有的点
        for (int i=0; i<obj.pointCount; i++) {
            // 取出点
            CGPoint point = obj.normalizedPoints[i];

        
            // 计算出center
            /*
             * 这里的 point 的 x,y 表示也比例, 表示当前点在脸的比例值
             * 因为Y点是在左下角， 所以我们需要转换成左上角
             * 这里的center 关键点 可以根据需求保存起来
             */
            CGPoint center = CGPointMake(faceRectX + faceRectWidth * point.x,  FFScreenHeight -
                                         (faceRectY + faceRectHeight * point.y));
            
            
            [array addObject:[NSValue valueWithCGPoint:CGPointMake(center.x/FFScreenWidth, center.y/FFScreenHeight)]];
            
            // 将点显示出来
            UIView *point_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 3)];
//            point_view.backgroundColor = UIColorRGBA(0xFF0000, 0.8);
            point_view.center = center;
            // 将点添加到imageView上即可 需要注意，当前image的bounds 应该和图片大小一样大
//            [self.gpuImageView addSubview:point_view];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 24, 12)];
            label.font = [UIFont systemFontOfSize:8.0];
//            label.textColor = UIColorRGBA(0x3333FF, 0.8);
            label.center = CGPointMake(center.x, center.y+5);
            label.text = [NSString stringWithFormat:@"%d",index];
//            [self.gpuImageView addSubview:label];
            index++;
        }
    }];
//    [FaceDetector shareInstance].landmarks = [array copy];
//    NSLog(@"index == %d",index);
}

- (void)setUniformsWithLandmarks:(NSArray <NSValue *>*)landmarks{
    int32_t size = 74 * 2;
    float *facePoints = (float *)malloc(size*sizeof(float));
    
    //这里只是单纯吧landMarks中的点放进float数组中
    int index = 0;
    for (NSValue *value in landmarks) {
        CGPoint point = [value CGPointValue];
        *(facePoints + index) = point.x;
        *(facePoints + index + 1) = point.y;
        index += 2;
        if (index == size) {
            break;
        }
    }
//    [self setFloatArray:facePoints length:size forUniform:facePointsUniform program:filterProgram];
    free(facePoints);
}


@end
