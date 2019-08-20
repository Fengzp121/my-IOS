//
//  FFZPMVVMView.m
//  FFwheel
//
//  Created by ffzp on 2019/8/19.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import "FFZPMVVMView.h"
#import "FFZPMVVMmodel.h"
@implementation FFZPMVVMView

-(instancetype)init{
    
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
    
}

-(void)initialize{
    
    self.succObj = [RACSubject subject];
    self.failObj = [RACSubject subject];
    self.modelData  = [FFZPMVVMmodel new];
    
}


@end
