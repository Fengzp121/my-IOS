//
//  urlArgumentsFilter.h
//  FFwheel
//
//  Created by ffzp on 2019/8/13.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKNetworkConfig.h"
#import "YTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface urlArgumentsFilter : NSObject<YTKUrlFilterProtocol>
+ (urlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;
@end

NS_ASSUME_NONNULL_END
