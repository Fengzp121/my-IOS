//
//  BitmapDemoVC.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/8/13.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "BitmapDemoVC.h"
#import "BMDemoTableViewCell.h"
#import <Masonry/Masonry.h>
@interface BitmapDemoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *bitmapImgArray;
@property (nonatomic,strong)NSMutableArray *normalImgArray;

@property (nonatomic,strong)NSMutableArray *imgViewArray;

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation BitmapDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.normalImgArray = [NSMutableArray array];
    self.bitmapImgArray = [NSMutableArray array];
    self.imgViewArray   = [NSMutableArray array];
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.scrollView.contentSize = self.view.bounds.size;
//    [self.view addSubview:self.scrollView];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    [self createNormalImg];
   // [self createImageView];
    [self createBitmapImg];
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();

    NSLog(@"耗时：%f ms", end - start);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

-(void)dealloc{
    NSLog(@"%@ was delloc normally!",NSStringFromClass([self class]));
}

-(void)createNormalImg{
    for (int i = 1; i <= 30; i++) {
        [self.normalImgArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i",i]]];
    }
}
-(void)createBitmapImg{
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 30; i++) {
        //UIImageView * imgV = (UIImageView *)self.imgViewArray[i];
//        dispatch_async(queue, ^{
//            UIImage * img = [self createBitmapImg:self.normalImgArray[i]];
//            [self.imgViewArray addObject:[self createDownSamplingImg:img]];
//           // dispatch_async(dispatch_get_main_queue(), ^{
//               // imgV.image = img;
//            //});
//        });
        
        [self.imgViewArray addObject:self.normalImgArray[i]];
    }
}

-(void)createImageView{
    for (int i = 0; i < 30; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.tag = 10000 + i;
        [self.scrollView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(i * 120);
            make.size.mas_equalTo(CGSizeMake(200, 100));
            make.centerX.equalTo(self.view);
        }];
        [self.imgViewArray addObject:imgView];
        //CGSize size = self.scrollView.contentSize;
        //size.height  = size.height + 120;
        //self.scrollView.contentSize = size;
    }
}

-(UIImage *)createBitmapImg:(UIImage *)image{
    // 1.获取image的cgimage，UIImage是归属UIKit框架的，只负责接收数据传递给QuartzCore结构体指针中的CGImage。
    //@autoreleasepool {
        CGImageRef imageRef = image.CGImage;
        

           // 2.获取原图的颜色空间参数
           CGColorSpaceRef colorspaceRef = CGColorSpaceCreateDeviceRGB();

           size_t width = CGImageGetWidth(imageRef);
           size_t height = CGImageGetHeight(imageRef);

           // 3.计算解码后每行需要的比特数，每存储一个像素需要比特数4
           size_t bytesPerRow = 4 * width;

           // 4.生成空白的图片进行绘制上下文
           CGContextRef context = CGBitmapContextCreate(NULL,
                                                        width,
                                                        height,
                                                        8,
                                                        bytesPerRow,
                                                        colorspaceRef,
                                                        kCGBitmapByteOrderDefault|kCGImageAlphaNoneSkipLast);
           if (context == NULL) {
               return image;
           }
                   
           // 5.将图片的指针写入到上下文中
           CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);

           // 6.根据上下文创建一个新的图片指针
           CGImageRef newImageRef = CGBitmapContextCreateImage(context);

           // 7.赋值给新的UIKit层的图片
           UIImage *newImage = [UIImage imageWithCGImage:newImageRef
                                                   scale:image.scale
                                             orientation:image.imageOrientation];

           //手动释放Core Foundation层的对象
           CGContextRelease(context);
           CGImageRelease(newImageRef);
        return newImage;
   // }
}

-(UIImage *)createDownSamplingImg:(UIImage *)image{
//    UIGraphicsBeginImageContext(CGSizeMake(200, 100));
//    [image drawInRect:CGRectMake(0, 0, 200, 100)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
    
    CGFloat maxPixelSize = 200;
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)UIImageJPEGRepresentation(image, 0.2), nil);
    NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:(__bridge id)kCFBooleanTrue,(__bridge id)kCGImageSourceThumbnailMaxPixelSize:[NSNumber numberWithFloat:maxPixelSize],(__bridge id)kCGImageSourceShouldCache:@NO};
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:2 orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    CFRelease(sourceRef);
    return newImage;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imgViewArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BMDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BMDemoTableViewCell class])];
    if (!cell) {
        cell = [[BMDemoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([BMDemoTableViewCell class])];
    }
    cell.img = self.imgViewArray[indexPath.row];
    cell.title = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
