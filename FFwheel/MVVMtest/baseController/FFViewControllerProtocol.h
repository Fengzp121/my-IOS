//
//  FFViewControllerProtocol.h
//  FFwheel
//
//  Created by 你吗 on 2020/11/12.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFViewModelProtocol;

@protocol FFViewControllerProtocol <NSObject>

@optional
-(instancetype)initWithViewModel:(id <FFViewModelProtocol>)viewModel;

-(void)ff_bindViewModel;
-(void)ff_addSubViews;
-(void)ff_layoutNavigation;
-(void)ff_getDataSource;
-(void)hideKeyboard;

@end
