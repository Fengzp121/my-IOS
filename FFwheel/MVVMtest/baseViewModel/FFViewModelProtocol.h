//
//  FFViewModelProtocol.h
//  FFwheel
//
//  Created by 你吗 on 2020/11/12.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFViewModelProtocol <NSObject>

@optional
-(instancetype)initWithModel:(id)model;


-(void)ff_initialize;

@end
