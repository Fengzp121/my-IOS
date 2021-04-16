//
//  ShineWhiteFilter.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/16.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "ShineWhiteFilter.h"
NSString * const kSCGPUImageShineWhiteFilterShaderString = SHADER_STRING
(
 precision highp float;
 
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 
 uniform float time;
 
 const float PI = 3.1415926;
 
 void main (void) {
     float duration = 0.7;
     
     float currentTime = mod(time, duration);
     
     vec4 whiteMask = vec4(1.0, 1.0, 1.0, 1.0);
     float amplitude = abs(sin(currentTime * (PI / duration)));
     
     vec4 mask = texture2D(inputImageTexture, textureCoordinate);
     
     gl_FragColor = mask * (1.0 - amplitude) + whiteMask * amplitude;
 }
);
@implementation ShineWhiteFilter
- (instancetype)init {
    self = [super initWithFragmentShaderFromString:kSCGPUImageShineWhiteFilterShaderString];
    self.timeUniform = [filterProgram uniformIndex:@"time"];
    return self;
}

- (void)setTime:(CGFloat)time {
    _time = time;
    [self setFloat:time forUniform:self.timeUniform program:filterProgram];
}

@end
