//
//  DmKItemProtocol.h
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DmKItemProtocol <NSObject>

@optional
//更新数据
-(void)updateData;

@required
//预热准备
-(void)prepareForReuse;
//配置或设置参数
-(void)configureWithParams:(NSDictionary *)params;

@end

