//
//  BeautyCameraVC.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/9.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "BeautyCameraVC.h"
#import <GPUImage/GPUImage.h>
#import "FFFaceDetect.h"

@interface BeautyCameraVC ()<GPUImageVideoCameraDelegate>
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@end

@implementation BeautyCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
