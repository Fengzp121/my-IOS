//
//  ChangeFaceFilter.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/7.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <GPUImage/GPUImage.h>

NS_ASSUME_NONNULL_BEGIN

//尝试下用opencv来获取人脸特征
@interface ChangeFaceFilter : GPUImageFilter
{
    GLint faceArrayUniform,iResolutionUniform,haveFaceUniform;
}
@property (nonatomic, assign) BOOL isHaveFace;

@property (nonatomic, assign) float thinFaceParam;

@property (nonatomic, assign) float eyeParam;

@property (nonatomic, assign) float noseParam;


//人脸特征点+滤镜实时，有点耗电喔。。。
- (void)setFacePointsArray:(NSArray *)pointArrays;

- (void)setCaptureDevicePosition:(AVCaptureDevicePosition)captureDevicePosition;

@end

NS_ASSUME_NONNULL_END
