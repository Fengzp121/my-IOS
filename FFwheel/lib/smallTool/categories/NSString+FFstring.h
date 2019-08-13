//
//  NSString+FFstring.h
//  FFwheel
//
//  Created by ffzp on 2019/1/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString(FFstring)
+(BOOL)isEmpty:(NSString *)str;         //检查是否为空字符
+(BOOL)isNotEmpty:(NSString *)str;         //和上面那个相反
+(BOOL)isrealMobile:(NSString *)str;        //检查是否符合手机号

@end


