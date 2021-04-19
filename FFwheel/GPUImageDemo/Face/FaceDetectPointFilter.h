//
//  FaceDetectPointFilter.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/8.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceDetectPointFilter : GPUImageFilter
@property (nonatomic, assign) GLfloat *facesPoints;
@property (nonatomic, assign) int facesPointCount;
@end

NS_ASSUME_NONNULL_END
