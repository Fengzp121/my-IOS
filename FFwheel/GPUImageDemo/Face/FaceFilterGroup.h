//
//  FaceFilterGroup.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "GPUImageFilterGroup.h"
#import "BeautifyFaceFilter.h"
#import "ChangeFaceFilter.h"
#import "FaceDetectPointFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceFilterGroup : GPUImageFilterGroup{
    BeautifyFaceFilter *beautifyFaceFilter;
    ChangeFaceFilter *changeFaceFilter;
    FaceDetectPointFilter *faceDetectPointFilter;
    
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}
@property (nonatomic, assign) CGFloat intensity;

@end

NS_ASSUME_NONNULL_END
