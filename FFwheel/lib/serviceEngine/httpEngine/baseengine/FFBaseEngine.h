//
//  FFBaseEngine.h
//  FFwheel
//
//  Created by ffzp on 2019/1/21.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service_Config.h"

@interface FFBaseEngine : NSObject
//获取请求ID
-(NSNumber *)getrequestID;
//get-post func
+(FFBaseEngine *)control:(NSObject *)control                                    //请求的controller
    Get_Post_ServiceType:(FFServiceType)ServiceType                             //请求服务器
                    path:(NSString *)path                                       //api
                   param:(NSDictionary *)param                                  //内容
             requestType:(FFAPIManagerRequestType)requestType                   //请求方式
               alertType:(DataEngineAlertType)alertType                         //alert操作类型
           progressBlock:(ProgressBlock)progressBlock                           //三个block
           completeBlock:(CompletionDataBlock)responseBlock
        errorButtonBlock:(ErrorAlertSelectIndexBlock)errorButtonBlock;

//upload-download func
+(FFBaseEngine *)control:(NSObject *)control
Upload_Download_ServiceType:(FFServiceType)ServiceType
                    path:(NSString *)path
                   param:(NSDictionary *)param
                dataName:(NSString *)dataName
                fileName:(NSString *)fileName
                dataType:(NSString *)dataType                                   //数据类型
             requestType:(FFAPIManagerRequestType)requestType
               alertType:(DataEngineAlertType)alertType
    upload_progressBlock:(ProgressBlock)progressBlock1                           //上传时操作
  download_progressBlock:(ProgressBlock)progressBlock2                           //下载时操作
           completeBlock:(CompletionDataBlock)responseBlock
        errorButtonBlock:(ErrorAlertSelectIndexBlock)errorButtonBlock;

+(FFBaseEngine *)control:(NSObject *)control
       Array_ServiceType:(FFServiceType)ServiceType
                    path:(NSString *)path
                   param:(NSDictionary *)param
               dataArray:(NSArray *)dataArray                                   //数组数据
                dataName:(NSString *)dataName
                fileName:(NSString *)fileName
                dataType:(NSString *)dataType                                   //数据类型
             requestType:(FFAPIManagerRequestType)requestType
               alertType:(DataEngineAlertType)alertType
    upload_progressBlock:(ProgressBlock)progressBlock1                           //上传时操作
  download_progressBlock:(ProgressBlock)progressBlock2                           //下载时操作
           completeBlock:(CompletionDataBlock)responseBlock
        errorButtonBlock:(ErrorAlertSelectIndexBlock)errorButtonBlock;
@end

 
