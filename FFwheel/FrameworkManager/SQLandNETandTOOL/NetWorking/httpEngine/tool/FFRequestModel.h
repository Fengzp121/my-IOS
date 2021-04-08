//
//  FFRequestModel.h
//  FFwheel
//
//  Created by ffzp on 2019/1/21.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service_Config.h"
@interface FFRequestModel : NSObject
/**
 *  网络请求参数
 */
@property (nonatomic, strong) NSString *apiMethodPath;              //网络请求地址
@property (nonatomic, assign) FFServiceType serviceType;            //服务器标识
@property (nonatomic, strong) NSDictionary *parameters;             //请求参数
@property (nonatomic, assign) FFAPIManagerRequestType requestType;  //网络请求方式
@property (nonatomic, copy) CompletionDataBlock responseBlock;      //请求着陆回调

// upload
// upload file
// download
// download file
@property (nonatomic, strong) NSString *dataFilePath;
@property (nonatomic, strong) NSString *dataName;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *dataType;
//data array upload
@property(nonatomic, strong) NSArray * dataArray;


// progressBlock
@property (nonatomic, copy) ProgressBlock uploadProgressBlock;
@property (nonatomic, copy) ProgressBlock downloadProgressBlock;

@end
