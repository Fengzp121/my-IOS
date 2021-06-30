//
//  ClientWKWeb.m
//  wkWebDemo
//
//  Created by ffzp on 2020/7/29.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "ClientWKWeb.h"

@interface ClientWKWeb ()

@end

@implementation ClientWKWeb

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"httpDemo.html" withExtension:nil];
//    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [self loadrequestWithStr:@"https://yljapp.jstxb.com"];
    
    self.isHideProcessView = NO;
    NSArray *arr = @[@"messgaeToOC"];
    [self addJSMsgWithArray:arr];
     
    UIButton *ocTojsBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 80, 40)];
    ocTojsBtn.backgroundColor = UIColor.redColor;
    [self.view addSubview:ocTojsBtn];
    [ocTojsBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)click{
    NSString *jsStr = @"ocCallJS('WK_ocCallJS:OC-->JS')";
    [self.wkWeb evaluateJavaScript:jsStr completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"%@----%@",obj, error);
    }];
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [super userContentController:userContentController didReceiveScriptMessage:message];
    if([message.name isEqualToString:@"messgaeToOC"]){
        NSLog(@"shareNew is log");
    }
}
@end
