//
//  NSObject+FFCancelRequest.m
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NSObject+FFCancelRequest.h"
#import <objc/runtime.h>

@implementation NSObject(FFCancelRequest)

//持续捕获requestID
-(FFCancelRequest *)cancelHandle{
    FFCancelRequest *request = objc_getAssociatedObject(self, @selector(cancelHandle));
    if(request == nil){
        request = [[FFCancelRequest alloc] init];
        objc_setAssociatedObject(self, @selector(cancelHandle), request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return request;
}

@end
