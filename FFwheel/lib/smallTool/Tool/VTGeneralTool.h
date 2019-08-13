//
//  VTGeneralTool.h
//  SZDT_Partents
//
//  Created by szdt on 15/3/23.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface VTGeneralTool : NSObject
+ (CGSize)boundingRectWithSize:(CGSize)size  font:(CGFloat)font text:(NSString *)text;
+ (UIColor *)colorWithHex:(NSString *)hexColor;
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

+ (NSString *)getCurrentDevice;

+ (NSString*)base64forData:(NSData*)theData;

/**
 *  各种字符串判断
 *
 */
+ (Boolean)isNumberCharaterString:(NSString *)str;
+ (Boolean)isCharaterString:(NSString *)str;
+ (Boolean)isNumberString:(NSString *)str;
+ (Boolean)hasillegalString:(NSString *)str;
+ (Boolean)isValidSmsString:(NSString *)str;
+ (BOOL)verifyEmail:(NSString*)email;
+ (BOOL)verifyPhone:(NSString*)phone;
+ (BOOL)verifyMobilePhone:(NSString*)phone;
+ (NSString *)getTimeString:(NSInteger)duration; //通过时长获取时分秒的字符串
+ (NSString *)cleanPhone:(NSString *)beforeClean;

/**
 *  把color变成image
 *
 *  @param color 传来的color
 *
 *  @return 返回iamge
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;
/**
 *  检查非法字符和中文
 *
 */
+ (BOOL)checkNoChar:(NSString *)str;
/**
 *  隐藏tabbar
 */
+ (void)hiddenTabBar;
/**
 *  显示tabbar
 */
+ (void)showTabBar;
/**
 *  检查电话号码合法性
 *
 */
+ (BOOL)checkPhoneNumInput:(NSString *)phoneNumber;
/**
 *  根据dict返回data
 *
 */
+ (NSData*)returnDataWithDictionary:(NSDictionary*)dict;
/**
 *  根据输入的日期 返回周几的字符串
 *
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
/**
 *  获取今日日期
 */
+ (NSString *)getDate;
/**
 *  获取当前周的日期数组
 *
 */
+ (NSArray *)getCurrentWeekDay:(NSDate *)date;
/**
 获取当前时间戳
 
 @return 时间戳
 */
+(NSString *)getDateStamp;

/**
 *  清除文件
 *
 */
+ (void)clearCache:(NSString *)path;


/**
 * 修发图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;
/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
/**
 * 生成GUID
 */
+ (NSString *)generateUuidString;



/**
 *  百度转火星坐标
 *
 */
+ (CLLocationCoordinate2D )bdToGGEncrypt:(CLLocationCoordinate2D)coord;
/**
 *  火星转百度坐标
 *
 */
+ (CLLocationCoordinate2D )ggToBDEncrypt:(CLLocationCoordinate2D)coord;
+(NSString  *)displayDataStyleWithNumber:(NSString *)timeNumber;


/**
 *  md5加密
 *
 *  @param inPutText 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+(NSString *) md5: (NSString *) inPutText;

/**
 textField 左边空出一定间距
 
 @param textField textFiedl
 @param leftWidth 距离
 */
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;

#pragma mark - plist

/**
 解析plist 文件
 
 @param dataArrayString 文件名
 @return 内容
 */
+(NSArray *)getPlistArrayWithName:(NSString *)dataArrayString;


/**
 根据类名返回类

 @param name 类名
 @return 类
 */

+(id)getClassWithName:(NSString *)name;

/**
 检测对象是否存在该属性
 
 @param instance 对象
 @param verifyPropertyName 属性名
 @return 结果
 */
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName;

/**
 根据类名创建类,带参数
 
 @param name 类名
 @param verifyPropertyDic 类属性
 @return 类
 */
+(id)getClassWithName:(NSString *)name verifyPropertyDic:(NSDictionary *)verifyPropertyDic;

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;
#pragma mark - url 

/**
 网址拼接

 @param topString 头地址
 @param supString 尾地址
 @return 拼接地址
 */
+(NSString *)pathUrlString:(NSString *)topString supString:(NSString *)supString;
@end
