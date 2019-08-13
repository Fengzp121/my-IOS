//
//  Service_Config.h
//  FFwheel
//
//  Created by ffzp on 2019/1/20.
//  Copyright © 2019 apple. All rights reserved.
//

#ifndef Service_Config_h
#define Service_Config_h

typedef NS_ENUM(NSUInteger, FFServiceType) {
    FFService,      //1号服务器
    TLService,      //2号服务器
    TestService,    //3号
};


typedef NS_ENUM(NSUInteger, FFAPIManagerRequestType){
    FFAPIManagerRequestTypeGet,                      //get请求
    FFAPIManagerRequestTypePost,                     //POST请求
    FFAPIManagerRequestTypePostUpload,               //POST数据请求
    FFAPIManagerRequestTypeGETDownload,              //下载文件请求，不做返回值解析
    FFAPIManagerRequestTypePostUploadImageArray      //post 上传图片数组
};

//返回的alert操作，可能不会用到。
typedef NS_ENUM(NSInteger, DataEngineAlertType) {
    DataEngineAlertType_None,
    DataEngineAlertType_Toast,
    DataEngineAlertType_Alert,
    DataEngineAlertType_ErrorView
};

typedef void (^ProgressBlock)(NSProgress *taskProgress);                //请求中操作
typedef void (^CompletionDataBlock)(id data, NSError *error);           //完成请求
typedef void (^ErrorAlertSelectIndexBlock)(NSUInteger buttonIndex);     //失败操作


#endif /* Service_Config_h */
