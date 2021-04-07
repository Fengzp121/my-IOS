//
//  BeautifyFaceFilter.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/7.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@class GPUImageCombinationFilter;

NS_ASSUME_NONNULL_BEGIN

@interface BeautifyFaceFilter : GPUImageFilterGroup{
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

@end

NS_ASSUME_NONNULL_END
