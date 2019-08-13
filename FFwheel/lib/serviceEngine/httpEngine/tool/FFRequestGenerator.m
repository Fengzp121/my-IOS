//
//  FFRequestGenerator.m
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFRequestGenerator.h"
#import "AFURLRequestSerialization.h"
#import "FFServerSetting.h"
@interface FFRequestGenerator()

@property (nonatomic,strong)AFHTTPRequestSerializer *httpRequestSerializer;             //请求串行器，AFfnet封装好的。

@end
@implementation FFRequestGenerator
#pragma mark -----public func
+(instancetype)sharedInstance{
    //延长这个发生器的生命周期
    static dispatch_once_t onceToken;
    static FFRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FFRequestGenerator alloc] init];
    });
    return sharedInstance;
}

//根据datamodel制作发生器
-(NSURLRequest *)generateWithRequestDataModel:(FFRequestModel *)dataModel{
    //服务器地址
    FFBaseServer *service = [[FFServerSetting sharedInstance] serviceType:dataModel.serviceType];
    //数据
    NSMutableDictionary *Params = [NSMutableDictionary dictionary];
    [Params addEntriesFromDictionary:dataModel.parameters];
    NSString *urlString = [self URLStringWithServiceUrl:service.ApiURL path:dataModel.apiMethodPath];
    NSError *error = nil;
    NSMutableURLRequest *request = nil;
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    if(dataModel.requestType == FFAPIManagerRequestTypeGet){
        request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:Params error:&error];
    }
    else if (dataModel.requestType == FFAPIManagerRequestTypePost){
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:Params error:&error];
    }
    
    else if (dataModel.requestType == FFAPIManagerRequestTypePostUpload){
        weak(weakSelf)
        request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:Params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (![weakSelf isEmptyString:dataModel.dataFilePath]) {
                NSURL *fileURL = [NSURL fileURLWithPath:dataModel.dataFilePath];
                NSString *name = dataModel.dataName?dataModel.dataName:@"data";
                NSString *fileName = dataModel.fileName?dataModel.fileName:@"data.zip";
                NSString *dataType = dataModel.dataType?dataModel.dataType:@"application/zip";
                NSError *error;
                if (dataModel.requestType == FFAPIManagerRequestTypePostUpload) {
                    [formData appendPartWithFileURL:fileURL
                                               name:name
                                           fileName:fileName
                                           mimeType:dataType
                                              error:&error];
                    
                }
            }
        } error:&error];
    }
    //urlrequest默认请求是get所以下载这里只设置了url.
    else if (dataModel.requestType == FFAPIManagerRequestTypeGETDownload){
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    }
    else if (dataModel.requestType == FFAPIManagerRequestTypePostUploadImageArray){
        request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:Params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSString *name = dataModel.dataName?dataModel.dataName:@"image";
                NSString *fileName = dataModel.fileName?dataModel.fileName:@"image.png";
                NSString *dataType = dataModel.dataType?dataModel.dataType:@"image/jpeg";
                for (int i = 0; i < dataModel.dataArray.count; i++) {
                    UIImage * image = dataModel.dataArray[i];
                    NSData *imageData  = UIImageJPEGRepresentation(image,1);
                    NSLog(@"------第%d张------",i);
                    if (imageData && [imageData isKindOfClass:[NSData class]]) {
                        fileName = [NSString stringWithFormat:@"%@%d.jpg",name,i];
                        [formData appendPartWithFileData:imageData
                                                    name:name
                                                fileName:fileName
                                                mimeType:dataType
                         ];
                    }
                }
            
        } error:&error];
    }

    if(error || request == nil){
        NSLog(@"NSMutableURLRequests生成失败：\n---------------------------\n\
              urlString:%@\n\
              \n---------------------------\n",urlString);
        return  nil;
    }
    request.timeoutInterval = 60.0f;        //请求超时时间
    return request;
}

#pragma mark -----private func
//拼接url
-(NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path{
    NSURL *url = [NSURL URLWithString:serviceUrl];
    if(![self isEmptyString:path]){
        url = [NSURL URLWithString:path relativeToURL:url];
        //NSLog(@"url:%@",url);
    }
    if(url == nil){
        NSLog(@"FFRequestGenerator--URL拼接错误:\n---------------------------\n\
              apiBaseUrl:%@\n\
              urlPath:%@\n\
              \n---------------------------\n",serviceUrl,path);
        return nil;
    }
    return [url absoluteString];
}

//检查字符串是否为空
- (BOOL)isEmptyString:(NSString *)string
{
    if (!string) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    return string.length == 0;
}

#pragma mark -----lazy load
-(AFHTTPRequestSerializer *)httpRequestSerializer{
    if(_httpRequestSerializer == nil){
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];          //只是初始化
        _httpRequestSerializer.timeoutInterval = 60.0f;                         //设置超时时间
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;//缓存政策？
        //[_httpRequestSerializer setValue:@"" forHTTPHeaderField:<#(nonnull NSString *)#>]
    }
    return _httpRequestSerializer;
}

@end
