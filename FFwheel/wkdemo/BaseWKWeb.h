//
//  BaseWKWeb.h
//  wkWebDemo
//
//  Created by ffzp on 2020/7/29.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

//wkweb的基类，网页vc都可以继承于该vc，集成统一管理
@interface BaseWKWeb : UIViewController<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,weak)WKWebView *wkWeb;
@property (nonatomic,strong,readonly)WKWebViewConfiguration *config;

///default is NO,是否隐藏进度条
@property (nonatomic,assign)BOOL isHideProcessView;

-(void)addJSMsgWithArray:(NSArray *)arr;
-(void)loadrequestWithStr:(NSString *)str;


/// 如果需要响应js方法，就需要重写，不需要调用此函数
/// @param msg 响应体
-(void)handleJsMsgWith:(WKScriptMessage *)msg;

///以下是向js发送消息的方法
-(void)sendSuccessWithFuntion:(NSString *)fun andData:(NSDictionary *)dic;
-(void)sendFailWithFuntion:(NSString *)fun andData:(NSDictionary *)dic;
-(void)sendCompleteWithFuntion:(NSString *)fun andData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
