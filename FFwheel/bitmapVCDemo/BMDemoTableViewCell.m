//
//  BMDemoTableViewCell.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/8/13.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "BMDemoTableViewCell.h"
@interface BMDemoTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIImage *store_img;
@end

@implementation BMDemoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 40, 20)];
        self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 200, 100)];
        [self.contentView addSubview:_titleL];
        [self.contentView addSubview:_imgV];
    }
    return self;
}
-(void)dealloc{
    NSLog(@"%@ was delloc normally!",NSStringFromClass([self class]));
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setImg:(UIImage *)img{
    _img = img;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if(!self.store_img)//存储当前整完的图片
            //self.store_img = [self createDownSamplingImg:img];
            self.store_img = [self createBitmapImg:img];
            //self.store_img = [self createDownSamplingImg:[self createBitmapImg:img]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_imgV.image = self.store_img;
        });
    });
    
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleL.text = title;
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
    UIGraphicsBeginImageContext(CGSizeMake(200, 100));
    [image drawInRect:CGRectMake(0, 0, 200, 100)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
//    CGFloat maxPixelSize = 200;
//    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)UIImageJPEGRepresentation(image, 0.2), nil);
//    NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:(__bridge id)kCFBooleanTrue,(__bridge id)kCGImageSourceThumbnailMaxPixelSize:[NSNumber numberWithFloat:maxPixelSize],(__bridge id)kCGImageSourceShouldCache:@NO};
//    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
//    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:2 orientation:image.imageOrientation];
//    CGImageRelease(imageRef);
//    CFRelease(sourceRef);
//    return newImage;
}

@end
