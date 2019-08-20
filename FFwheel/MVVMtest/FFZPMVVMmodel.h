//
//  FFZPMVVMmodel.h
//  FFwheel
//
//  Created by ffzp on 2019/8/19.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(NSDictionary *dic);
typedef void(^Failure)(NSDictionary *dic);

NS_ASSUME_NONNULL_BEGIN

@interface FFZPMVVMmodel : NSObject

//获取数据，成功失败
-(void)getDataSuccess:(Success)success AndFailure:(Failure)failure;


@end

NS_ASSUME_NONNULL_END
