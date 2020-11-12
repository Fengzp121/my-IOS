//
//  FFViewModel.m
//  FFwheel
//
//  Created by 你吗 on 2020/11/12.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "FFViewModel.h"

@implementation FFViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    FFViewModel *viewModel = [super allocWithZone:zone];
    if(viewModel){
        [viewModel ff_initialize];
    }
    return  viewModel;
}

- (instancetype)initWithModel:(id)model{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)ff_initialize {}

@end
