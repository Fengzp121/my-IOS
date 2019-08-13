//
//  FFBaseEngine.m
//  FFwheel
//
//  Created by ffzp on 2019/1/21.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFBaseEngine.h"
#import "FFRequestModel.h"
#import "NSObject+FFCancelRequest.h"
#import "FFBusinessTier.h"
#import "NSString+tojson.h"

@interface FFBaseEngine()

@property (nonatomic, strong) NSNumber *requestID;

@end

@implementation FFBaseEngine
//清除
-(void)dealloc{
    [self cancelRequest];
}

+(FFBaseEngine *)control:(NSObject *)control Get_Post_ServiceType:(FFServiceType)ServiceType path:(NSString *)path param:(NSDictionary *)param requestType:(FFAPIManagerRequestType)requestType alertType:(DataEngineAlertType)alertType progressBlock:(ProgressBlock)progressBlock completeBlock:(CompletionDataBlock)responseBlock errorButtonBlock:(ErrorAlertSelectIndexBlock)errorButtonBlock{
    
    return [self control:control Array_ServiceType:ServiceType path:path param:param dataArray:nil dataName:nil fileName:nil dataType:nil requestType:requestType alertType:alertType upload_progressBlock:progressBlock download_progressBlock:nil completeBlock:responseBlock errorButtonBlock:errorButtonBlock];
}

+(FFBaseEngine *)control:(NSObject *)control Upload_Download_ServiceType:(FFServiceType)ServiceType path:(NSString *)path param:(NSDictionary *)param dataName:(NSString *)dataName fileName:(NSString *)fileName dataType:(NSString *)dataType requestType:(FFAPIManagerRequestType)requestType alertType:(DataEngineAlertType)alertType upload_progressBlock:(ProgressBlock)progressBlock1 download_progressBlock:(ProgressBlock)progressBlock2 completeBlock:(CompletionDataBlock)responseBlock errorButtonBlock:(ErrorAlertSelectIndexBlock)errorButtonBlock{
    
    return [self control:control Array_ServiceType:ServiceType path:path param:param dataArray:nil dataName:dataName fileName:fileName dataType:dataType requestType:requestType alertType:alertType upload_progressBlock:progressBlock1 download_progressBlock:progressBlock2 completeBlock:responseBlock errorButtonBlock:errorButtonBlock];
}

//主要
+(FFBaseEngine *)control:(NSObject *)control Array_ServiceType:(FFServiceType)ServiceType path:(NSString *)path param:(NSDictionary *)param dataArray:(NSArray *)dataArray dataName:(NSString *)dataName fileName:(NSString *)fileName dataType:(NSString *)dataType requestType:(FFAPIManagerRequestType)requestType alertType:(DataEngineAlertType)alertType upload_progressBlock:(ProgressBlock)progressBlock1 download_progressBlock:(ProgressBlock)progressBlock2 completeBlock:(CompletionDataBlock)responseBlock errorButtonBlock:(ErrorAlertSelectIndexBlock)errorButtonBlock{
    FFBaseEngine * engine = [[FFBaseEngine alloc] init];
    __weak typeof(control) weakControl = control;
    FFRequestModel *dataModel = [engine Model_ServiceType:ServiceType path:path param:param dataArray:dataArray dataName:dataName fileName:fileName dataType:dataType requestType:requestType alertType:alertType upload_progressBlock:progressBlock1 download_progressBlock:progressBlock2 completeBlock:^(id data, NSError *error){
        if(responseBlock){
            //对下载的json未进行解析
            
            //json解析
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            id data = [str JSONValue];
            
            responseBlock(data,error);
        }
         //中断请求操作。
        [weakControl.cancelHandle removeEngine_RequestWithRequestID:engine.requestID];
    }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}

//添加model
-(FFRequestModel *)Model_ServiceType:(FFServiceType)ServiceType path:(NSString *)path param:(NSDictionary *)param dataArray:(NSArray *)dataArray dataName:(NSString *)dataName fileName:(NSString *)fileName dataType:(NSString *)dataType requestType:(FFAPIManagerRequestType)requestType alertType:(DataEngineAlertType)alertType upload_progressBlock:(ProgressBlock)progressBlock1 download_progressBlock:(ProgressBlock)progressBlock2 completeBlock:(CompletionDataBlock)responseBlock{
    
    FFRequestModel *dataModel = [[FFRequestModel alloc] init];
    dataModel.serviceType = ServiceType;
    dataModel.apiMethodPath = [self pathUrlString:@"" supString:path];
    dataModel.parameters = param;
    dataModel.dataArray = dataArray;
    dataModel.dataName = dataName;
    dataModel.fileName = fileName;
    dataModel.dataType = dataType;
    dataModel.requestType = requestType;
    dataModel.uploadProgressBlock = progressBlock1;
    dataModel.downloadProgressBlock = progressBlock2;
    dataModel.responseBlock = responseBlock;
    return dataModel;
}

-(void)callRequestWithRequestModel:(FFRequestModel *)dataModel control:(NSObject *)control{
    self.requestID = [[FFBusinessTier sharedInstance] callRequestWithRequestModel:dataModel];
    [control.cancelHandle setEngine:self requestID:self.requestID];
}

-(void)cancelRequest{
    [[FFBusinessTier sharedInstance]cancelRequestWithRequestID:self.requestID];
}

-(NSNumber *)getrequestID{
    return self.requestID;
}


-(NSString *)pathUrlString:(NSString *)topString supString:(NSString *)supString{
  if ([topString hasSuffix:@"/"]) {
      topString = [topString substringToIndex:topString.length - 1];
    }
    if ([supString hasPrefix:@"/"]) {
    supString = [supString substringFromIndex:1];
    }
    return [NSString stringWithFormat:@"%@/%@",topString,supString];
    }

                               
@end
