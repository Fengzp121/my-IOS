//
//  ShakeFilter.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/16.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "ShakeFilter.h"

NSString * const kSCGPUImageShakeFilterShaderString = SHADER_STRING
(
 precision highp float;
 
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 
 uniform float time;
 
 void main (void) {
     float duration = 0.6;
     float maxScale = 1.2;
     float offset = 0.02;
     
     float progress = mod(time, duration) / duration;
     vec2 offsetCoords = vec2(offset, offset) * progress;
     float scale = 1.0 + (maxScale - 1.0) * progress;
     
     vec2 scaleTextureCoords = vec2(0.5, 0.5) + (textureCoordinate - vec2(0.5, 0.5)) / scale;
     
     vec4 maskR = texture2D(inputImageTexture, scaleTextureCoords + offsetCoords);
     vec4 maskB = texture2D(inputImageTexture, scaleTextureCoords - offsetCoords);
     vec4 mask = texture2D(inputImageTexture, scaleTextureCoords);
     
     gl_FragColor = vec4(maskR.r, mask.g, maskB.b, mask.a);
 }
);

@implementation ShakeFilter

- (instancetype)init {
    self = [super initWithFragmentShaderFromString:kSCGPUImageShakeFilterShaderString];
    self.timeUniform = [filterProgram uniformIndex:@"time"];
    return self;
}

- (void)setTime:(CGFloat)time {
    _time = time;
    [self setFloat:time forUniform:self.timeUniform program:filterProgram];
}

@end
