//
//  FFRequestErrorHandle.m
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "FFRequestErrorHandle.h"
#import "NSDictionary+toString.h"
@implementation FFRequestErrorHandle
+(void)errorHandleWithRequestdataModel:(FFRequestModel *)dataModel responseURL:(NSString *)resonserURL responseObject:(id)responseObject error:(NSError *)error errorHandler:(void (^)(NSError *))errorHandle{
    NSInteger errorCode = 10086;
    NSString *message = @" ";
    if(error){
        //设置错误码，并对message添加相应的说明文字
        errorCode = error.code;
        message = [self errorWithCode:errorCode];
    }else{
        //没有错误码，就从返回的数据获取说明
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *data = [string mj_JSONObject];

        if([data isKindOfClass:[NSDictionary class]]){
            //toString是在字典中取值赋值的操作
            message = [data toString:string];
        }else{
            //这里需要和后台对接
            errorCode = -10010;
            message = @"返回错误";
        }
    }
    //错误操作,没错也给个block操作
    if(errorCode != 10086){
        //这里生成新的error
        error = [[NSError alloc]initWithDomain:NSCocoaErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:message,@"URL":resonserURL}];
        if(errorHandle){
            errorHandle(error);
        }
    }else{
        if(errorHandle){
            errorHandle(nil);
        }
    }
    
}



//afnet 的常规错误码
+(NSString *)errorWithCode:(NSInteger)code
{
    switch (code) {
            
        case -1://NSURLErrorUnknown
        {
            return @"未知错误";
        }
            
            break;
        case -999://NSURLErrorCancelled
        {
            return @"无效的URL地址";
        }
            
            break;
        case -1000://NSURLErrorBadURL
        {
            return @"无效的URL地址";
        }
            
            break;
        case -1001://NSURLErrorTimedOut
        {
            return @"网络不给力，请稍后再试";
        }
            
            break;
        case -1002://NSURLErrorUnsupportedURL
        {
            return @"不支持的URL地址";
        }
            
            break;
        case -1003://NSURLErrorCannotFindHost
        {
            return @"找不到服务器";
        }
            
            break;
        case -1004://NSURLErrorCannotConnectToHost
        {
            return @"连接不上服务器";
        }
            
            break;
        case -1103://NSURLErrorDataLengthExceedsMaximum
        {
            return @"请求数据长度超出最大限度";
        }
            
            break;
        case -1005://NSURLErrorNetworkConnectionLost
        {
            return @"网络连接异常";
        }
            
            break;
        case -1006://NSURLErrorDNSLookupFailed
        {
            return @"DNS查询失败";
        }
            
            break;
        case -1007://NSURLErrorHTTPTooManyRedirects
        {
            return @"HTTP请求重定向";
        }
            
            break;
        case -1008://NSURLErrorResourceUnavailable
        {
            return @"资源不可用";
        }
            
            break;
        case -1009://NSURLErrorNotConnectedToInternet
        {
            return @"无网络连接";
        }
            
            break;
        case -1010://NSURLErrorRedirectToNonExistentLocation
        {
            return @"重定向到不存在的位置";
        }
            
            break;
        case -1011://NSURLErrorBadServerResponse
        {
            return @"服务器响应异常";
        }
            
            break;
        case -1012://NSURLErrorUserCancelledAuthentication
        {
            return @"用户取消授权";
        }
            
            break;
        case -1013://NSURLErrorUserAuthenticationRequired
        {
            return @"需要用户授权";
        }
            
            break;
        case -1014://NSURLErrorZeroByteResource
        {
            return @"零字节资源";
        }
            
            break;
        case -1015://NSURLErrorCannotDecodeRawData
        {
            return @"无法解码原始数据";
        }
            
            break;
        case -1016://NSURLErrorCannotDecodeContentData
        {
            return @"无法解码内容数据";
        }
            
            break;
        case -1017://NSURLErrorCannotParseResponse
        {
            return @"无法解析响应";
        }
            
            break;
        case -1018://NSURLErrorInternationalRoamingOff
        {
            return @"国际漫游关闭";
        }
            
            break;
        case -1019://NSURLErrorCallIsActive
        {
            return @"被叫激活";
        }
            
            break;
        case -1020://NSURLErrorDataNotAllowed
        {
            return @"数据不被允许";
        }
            
            break;
        case -1021://NSURLErrorRequestBodyStreamExhausted
        {
            return @"请求体";
        }
            
            break;
        case -1100://NSURLErrorFileDoesNotExist
        {
            return @"文件不存在";
        }
            
            break;
        case -1101://NSURLErrorFileIsDirectory
        {
            return @"文件是个目录";
        }
            
            break;
        case -1102://NSURLErrorNoPermissionsToReadFile
        {
            return @"无读取文件权限";
        }
            
            break;
        case -1200://NSURLErrorSecureConnectionFailed
        {
            return @"安全连接失败";
        }
            
            break;
        case -1201://NSURLErrorServerCertificateHasBadDate
        {
            return @"服务器证书失效";
        }
            
            break;
        case -1202://NSURLErrorServerCertificateUntrusted
        {
            return @"不被信任的服务器证书";
        }
            
            break;
        case -1203://NSURLErrorServerCertificateHasUnknownRoot
        {
            return @"未知Root的服务器证书";
        }
            
            break;
        case -1204://NSURLErrorServerCertificateNotYetValid
        {
            return @"服务器证书未生效";
        }
            
            break;
        case -1205://NSURLErrorClientCertificateRejected
        {
            return @"客户端证书被拒";
        }
            
            break;
        case -1206://NSURLErrorClientCertificateRequired
        {
            return @"需要客户端证书";
        }
            
            break;
        case -2000://NSURLErrorCannotLoadFromNetwork
        {
            return @"无法从网络获取";
        }
            
            break;
        case -3000://NSURLErrorCannotCreateFile
        {
            return @"无法创建文件";
        }
            
            break;
        case -3001:// NSURLErrorCannotOpenFile
        {
            return @"无法打开文件";
        }
            
            break;
        case -3002://NSURLErrorCannotCloseFile
        {
            return @"无法关闭文件";
        }
            
            break;
        case -3003://NSURLErrorCannotWriteToFile
        {
            return @"无法写入文件";
        }
            
            break;
        case -3004://NSURLErrorCannotRemoveFile
        {
            return @"无法删除文件";
        }
            
            break;
        case -3005://NSURLErrorCannotMoveFile
        {
            return @"无法移动文件";
        }
            
            break;
        case -3006://NSURLErrorDownloadDecodingFailedMidStream
        {
            return @"下载解码数据失败";
        }
            
            break;
        case -3007://NSURLErrorDownloadDecodingFailedToComplete
        {
            return @"下载解码数据失败";
        }
            
        default:
            return @" ";
            break;
    }
    return @"";
}
//{
//    switch (code) {
//        case 3:
//        {
//            return @"Token过期";
//        }
//            break;
//        case -1001:
//        {
//            return @"请求超时";
//        }
//            break;
//        case -1004:
//        {
//            return @"没有网络连接";
//        }
//            break;
//        case -1003:
//        {
//            return @"没有找到服务器";
//        }
//            break;
//        case -1011:
//        {
//            return @"服务器错误";
//        }
//            break;
//        default:
//        {
//            return @"未知错误";
//        }
//            break;
//    }
//    return @"";
//}

@end
