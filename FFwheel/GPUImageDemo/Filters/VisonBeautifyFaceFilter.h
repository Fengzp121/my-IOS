//
//  VisonBeautifyFaceFilter.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/13.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "GPUImageFilter.h"
#import "FFFaceDetect.h"
NS_ASSUME_NONNULL_BEGIN

@interface VisonBeautifyFaceFilter : GPUImageFilter

@property(nonatomic, assign) CGFloat thinFaceDelta;
@property(nonatomic, assign) CGFloat bigEyeDelta;

@end

NS_ASSUME_NONNULL_END
