//
//  FFZPMVVMView.h
//  FFwheel
//
//  Created by ffzp on 2019/8/19.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFZPMVVMmodel;
NS_ASSUME_NONNULL_BEGIN

@interface FFZPMVVMView : NSObject

@property (nonatomic,strong)RACSubject *succObj;
@property (nonatomic,strong)RACSubject *failObj;
@property (nonatomic,strong)FFZPMVVMmodel *modelData;

@end

NS_ASSUME_NONNULL_END
