//
//  TextToImageTool.h
//  FFwheel
//
//  Created by 你吗 on 2021/3/18.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextToImageTool : NSObject
+ (UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes;
@end

NS_ASSUME_NONNULL_END
