//
//  FFdataEngine.h
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFBaseEngine.h"

#define CorrectCode 0 //正确返回码

/**
 *  请求成功回调block
 *
 *  @param data model类
 *  @param code      返回码
 */
typedef void(^FFHttpToolRequestBlock) (id data ,int code,NSString * message);
/**
 *  请求失败回调
 *
 *  @param error 错误信息
 */
typedef void(^FFhttpToolerrorBlock) (NSError * error);

typedef NS_ENUM(NSInteger, FFTimeComponentType) {
    FFTimeComponentTypeNow,                 //立即处理
    FFTimeComponentTypeNomor                //暂缓操作,目的是为了检查缓存后再进行请求
};


@interface FFdataEngine : NSObject
//构造器
+(id)sharedInstance;

//测试接口
-(FFBaseEngine *)TestDataAPI:(NSObject *)control content:(NSString *)content requestBlock:(FFHttpToolRequestBlock)requestBlock errorBlock:(FFhttpToolerrorBlock)errorBlock;

//登录用，可能还需要个t
-(FFBaseEngine *)VerificatCheckAPI:(NSObject *)control phoneNum:(NSString *)username verification:(NSString *)verification requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock;

//登录用，可能还需要个token
-(FFBaseEngine *)LoginApi:(NSObject *)control phoneNum:(NSString *)phoneNum password:(NSString *)password requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock;

//测试图片上传接口
-(FFBaseEngine *)ImageUploadApi:(NSObject *)control imageArray:(NSArray <UIImage *>*)imageArray requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock;

//下载接口
-(FFBaseEngine *)Image_DownloadApi:(NSObject *)control requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock;

//图片和文字接口
-(FFBaseEngine *)Image_Content_uploadApi:(NSObject *)control content:(NSString *)content imageArray:(NSArray <UIImage *>*)imageArray requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock;

@end

