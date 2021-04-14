//
//  FFFaceDetect.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/8.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FFFaceDetectType){
    FFFaceDetectType_OPENCV,
    FFFaceDetectType_FACEPP,
    FFFaceDetectType_VISION,
    FFFaceDetectType_TENSORFLOW,
};

NS_ASSUME_NONNULL_BEGIN

@interface FFFaceDetect : NSObject

@property (nonatomic, assign) CGSize sampleBufferSize;

@property (nonatomic, assign) FFFaceDetectType faceDetectType;

@property (nonatomic, copy) NSArray *landmarks;

+ (instancetype)defaultInstance;

- (void)start;

- (void)stop;

- (void)licenseFacepp;

- (float *)detectWithSampleBuffer:(CMSampleBufferRef)sampleBuffer facePointCount:(int *)facePointCount isMirror:(BOOL)isMirror;

- (void)visionDetectWithSampleBuffer:(CMSampleBufferRef)sampleBuffer completHandler:(void(^)(void))completHandler;

@end

NS_ASSUME_NONNULL_END
