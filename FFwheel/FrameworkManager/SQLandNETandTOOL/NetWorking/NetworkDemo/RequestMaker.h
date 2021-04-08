//
//  RequestMaker.h
//  FFwheel
//
//  Created by ffzp on 2020/9/14.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

@interface RequestMaker : NSObject
+(instancetype)ShareInstance;
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@end

NS_ASSUME_NONNULL_END
