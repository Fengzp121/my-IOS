//
//  VideoEditorViewController.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/4.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "VideoEditorViewController.h"

@interface VideoEditorViewController ()

@end

@implementation VideoEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//AVAsset* asset = [AVAssetassetWithURL:[NSURLfileURLWithPath:self.curentModel.localPath]];
//AVAssetTrack *clipVideoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
//AVMutableVideoComposition* videoComposition = [AVMutableVideoCompositionvideoComposition];
//videoComposition.frameDuration = CMTimeMake(1, 30);



//  CMTime start = CMTimeMakeWithSeconds(cutBegin, asset.duration.timescale);
//  CMTime duration = CMTimeMakeWithSeconds(cutEnd, asset.duration.timescale);
//  CMTimeRange range = CMTimeRangeMake(start, duration);
//  exportSession.timeRange = range;
//   [exportSession setVideoComposition:videoComposition];
//   exportSession.outputURL = [NSURL fileURLWithPath:desPath];
//   exportSession.outputFileType = AVFileTypeMPEG4;
//   __block BOOL copyOK = NO;
//   [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
//        switch (exportSession.status){
//            caseAVAssetExportSessionStatusUnknown:
//                break;
//            caseAVAssetExportSessionStatusWaiting:
//                MyLog(@"------视频ok-----waiting");
//                break;
//            caseAVAssetExportSessionStatusExporting:
//                MyLog(@"------视频ok-----expotring");
//                break;
//            caseAVAssetExportSessionStatusCompleted:
//                MyLog(@"------视频ok");
//                copyOK=YES;
//                break;
//            caseAVAssetExportSessionStatusFailed:
//                MyLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
//                break;
//            caseAVAssetExportSessionStatusCancelled:
//                break;
//            default:
//                break;
//        }
//        if (copyOK) {}else{}
//    }];

//   1 - Set up the text layer
//   CATextLayer *subtitle1Text = [[CATextLayer alloc] init];
//   [subtitle1Text setFont:@"Helvetica-Bold"];
//   [subtitle1Text setFontSize:36];
//   [subtitle1Text setFrame:CGRectMake(0, 0, size.width, 100)];
//   [subtitle1Text setString:_subTitle1.text];
//   [subtitle1Text setAlignmentMode:kCAAlignmentCenter];
//   [subtitle1Text setForegroundColor:[[UIColor whiteColor] CGColor]];
//
//   2 - The usual overlay
//   CALayer *overlayLayer = [CALayer layer];
//   [overlayLayer addSublayer:subtitle1Text];
//   overlayLayer.frame = CGRectMake(0, 0, size.width, size.height);
//   [overlayLayer setMasksToBounds:YES];
//
//   CALayer *parentLayer = [CALayer layer];
//   CALayer *videoLayer = [CALayer layer];
//   parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
//   videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
//   [parentLayer addSublayer:videoLayer];
//   [parentLayer addSublayer:overlayLayer];
//
//   composition.animationTool = [AVVideoCompositionCoreAnimationTool
//                                videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
//


@end
