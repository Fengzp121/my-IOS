//
//  GlitchFilter.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/16.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlitchFilter : GPUImageFilter
@property (nonatomic, assign) CGFloat time;
@property (nonatomic, assign) GLint timeUniform;
@end

NS_ASSUME_NONNULL_END
