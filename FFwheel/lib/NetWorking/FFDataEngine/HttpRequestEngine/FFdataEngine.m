//
//  FFdataEngine.m
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFdataEngine.h"
#import "NSDictionary+toString.h"


@interface FFdataEngine()
@property (nonatomic, copy)FFHttpToolRequestBlock requestBlock;
@property (nonatomic, copy)FFhttpToolerrorBlock errorBlock;
@property (nonatomic, strong)NSMutableDictionary * params;//参数字典
@end

@implementation FFdataEngine

+(id)sharedInstance{
    //static FFdataEngine *dataEngine = nil;
    //if(dataEngine == nil)
    return [[FFdataEngine alloc] init];
}


//正常的get和post
-(FFBaseEngine *)get_post_httpPath:(NSString *)path control:(NSObject *)control requestService:(FFServiceType)Service requestType:(FFAPIManagerRequestType)requestType{
    FFBaseEngine * engine = nil;
    engine = [FFBaseEngine control:control
              Get_Post_ServiceType:Service
                              path:path
                             param:self.params
                       requestType:requestType
                         alertType:DataEngineAlertType_None
                     progressBlock:nil
                     completeBlock:^(id data, NSError *error){
                         //数据处理
                         [self DealData:data error:error url:path requestID:[engine getrequestID] control:control];
                     }
                  errorButtonBlock:nil];
    return engine;
}


//图片数组接口,设计媒体数据的都直接使用这个接口。
-(FFBaseEngine *)uploadArray_httpPath:(NSString *)path requestService:(FFServiceType)Service control:(NSObject *)control  dataArray:(NSArray<UIImage *> *)dataArray{
    FFBaseEngine *engine = nil;
    NSString * str = @"files";
    //NSString * requestTime = [VTGeneralTool getDateStamp];
    //[NSString stringWithFormat:@"%@.jpg",[VTGeneralTool getDateStamp]]
    engine = [FFBaseEngine control:control
                 Array_ServiceType:Service
                              path:path
                             param:self.params
                         dataArray:dataArray
                          dataName:str
                          fileName:[NSString stringWithFormat:@"%@.jpg",str]
                          dataType:@"image/jpeg"
                       requestType:FFAPIManagerRequestTypePostUploadImageArray
                         alertType:DataEngineAlertType_None
              upload_progressBlock:nil
            download_progressBlock:nil
                     completeBlock:^(id data, NSError *error) {
        //数据处理
                         [self DealData:data error:error url:path requestID:[engine getrequestID] control:control];
                     }
                  errorButtonBlock:nil];
    return engine;
}

//除了图片数组和视频的上传，其他接口都从这里进入
-(FFBaseEngine *)setRequestWithControl:(NSObject *)control path:(NSString *)path requestService:(FFServiceType)Service dataRequestType:(FFTimeComponentType)dataRequestType requestType:(FFAPIManagerRequestType)requestType requestBlock:(FFHttpToolRequestBlock)requestBlock errorBlock:(FFhttpToolerrorBlock)errorBlock{
    switch (dataRequestType) {
        case FFTimeComponentTypeNow:
        {
            _requestBlock = requestBlock;
            _errorBlock = errorBlock;
            return [self get_post_httpPath:path control:control requestService:Service requestType:requestType];
        }
            break;
        case FFTimeComponentTypeNomor:
            
            return nil;
            //检查缓存,缓存存在就不发出请求。
            break;
        default:
            break;
    }
}


-(void)DealData:(id)data error:(NSError *)error url:(NSString *)url requestID:(NSNumber *)requestID control:(NSObject *)contorl{
    if(error){
        _errorBlock(error); //这是给界面的错误处理，就是发生在下面那个错误后进行的操作
        return;
    }
    if(data && [data isKindOfClass:[NSDictionary class]]){
        //以下是解析json，将三个数据分开
        NSString *message = [data toString:@"msg"];         //返回的消息
        int code = [data toInt:@"code"];                        //返回的正确码
        id dealedData = [data toObject:@"data"];                //返回的数据
        //cleanCode
        NSLog(@"\n---------http连接成功---------\nFFdataEngine:\n{\n   code:%i\n   data:%@\n   msg:%@\n}",code,dealedData,message);
        if(code != CorrectCode){
            //处理返回的错误
            [self errorWithCode:code Message:message control:contorl];
        }
        _requestBlock(dealedData,code,message);     //成功处理，将数据给到界面
        
        //本地保存该记录
        
        
    }
}

-(void)errorWithCode:(NSInteger)code Message:(NSString *)message control:(NSObject *)control{
    switch (code) {
        case 1:
            NSLog(@"code:1错误:%@",message);
            break;
        default:
            NSLog(@"后台的其他未知锅:%@",message);
            break;
    }
}


//测试接口
-(FFBaseEngine *)TestDataAPI:(NSObject *)control content:(NSString *)content requestBlock:(FFHttpToolRequestBlock)requestBlock errorBlock:(FFhttpToolerrorBlock)errorBlock{
    //FFService    /user/v1/138
    return [self setRequestWithControl:control path:@"/user/fuck1" requestService:TLService dataRequestType:FFTimeComponentTypeNow requestType:FFAPIManagerRequestTypeGet requestBlock:requestBlock errorBlock:errorBlock];
}


-(FFBaseEngine *)LoginApi:(NSObject *)control phoneNum:(NSString *)username password:(NSString *)password requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock{
    [self.params setValue:password forKey:@"password"];
    [self.params setValue:username forKey:@"username"];
    NSLog(@"self.params:%@",self.params);
    return [self setRequestWithControl:control path:@"/user/app/verifyMsgCode" requestService:FFService dataRequestType:FFTimeComponentTypeNow requestType:FFAPIManagerRequestTypePost requestBlock:requestBlokc errorBlock:errorBlock];
}


-(FFBaseEngine *)VerificatCheckAPI:(NSObject *)control phoneNum:(NSString *)phoneNum verification:(NSString *)verification requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock{
    [self.params setValue:phoneNum forKey:@"phoneNumber"];
    [self.params setValue:verification forKey:@"verification"];
    return [self setRequestWithControl:control path:@"/user/app/verifyMsgCheck" requestService:FFService dataRequestType:FFTimeComponentTypeNow requestType:FFAPIManagerRequestTypePost requestBlock:requestBlokc errorBlock:errorBlock];
}

-(FFBaseEngine *)ImageUploadApi:(NSObject *)control imageArray:(NSArray<UIImage *> *)imageArray requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock{
    _requestBlock = requestBlokc;
    _errorBlock = errorBlock;
    return  [self uploadArray_httpPath:@"/user/uploadImage" requestService:TLService control:control dataArray:imageArray];
}

-(FFBaseEngine *)Image_DownloadApi:(NSObject *)control requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock{
    //return [self get_post_httpPath:@"user/downloadImage/123.png" control:control requestService:TLService requestType:FFAPIManagerRequestTypeGETDownload];
    return [self setRequestWithControl:control path:@"user/getImageUrl/123.png" requestService:TLService dataRequestType:FFTimeComponentTypeNow requestType:FFAPIManagerRequestTypeGet requestBlock:requestBlokc errorBlock:errorBlock];
}

-(FFBaseEngine *)Image_Content_uploadApi:(NSObject *)control content:(NSString *)content imageArray:(NSArray<UIImage *> *)imageArray requesBlock:(FFHttpToolRequestBlock)requestBlokc errorBlock:(FFhttpToolerrorBlock)errorBlock{
    [self.params setValue:content forKey:@"name"];
    [self.params setValue:@"fuck-password" forKey:@"password"];
    [self.params setValue:@"fuck-username" forKey:@"username"];
    _requestBlock = requestBlokc;
    _errorBlock = errorBlock;
    return [self uploadArray_httpPath:@"/users/register" requestService:FFService control:control dataArray:imageArray];
}


#pragma mark -----lazy load
-(NSMutableDictionary *)params{
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
        //        if (_fewApp.userToken == nil) {
        //            [self.params setValue:@"" forKey:@"token"];
        //        }else{
        //            [self.params setValue:_fewApp.userToken forKey:@"token"];
        //        }
    }
    return _params;
}
@end
