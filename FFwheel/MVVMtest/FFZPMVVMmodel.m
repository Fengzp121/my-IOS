//
//  FFZPMVVMmodel.m
//  FFwheel
//
//  Created by ffzp on 2019/8/19.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import "FFZPMVVMmodel.h"

@implementation FFZPMVVMmodel

-(void)getDataSuccess:(Success)success AndFailure:(Failure)failure{
    //请求下来的数组字典
    NSArray  *result =@[@{@"title":@"我是谁",
                          @"tag":@1,
                          },
                        @{@"title":@"我从哪来",
                          @"img":@2,
                          },
                        @{@"title":@"要到哪去",
                          @"img":@3,
                          }];
    
    if (result.count > 0) {
        //注意小写
        success(@{@"data":result});
        
    }else{
        failure(@{@"error":@"no data"});
        
    }
    
}


@end
