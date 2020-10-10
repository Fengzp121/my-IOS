//
//  BaseWKWeb.m
//  wkWebDemo
//
//  Created by ffzp on 2020/7/29.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "BaseWKWeb.h"

@interface BaseWKWeb ()
@property (nonatomic,strong)WKWebViewConfiguration *config;
@property (nonatomic,copy)NSArray *jsMsgArray;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation BaseWKWeb
-(instancetype)init{
    if (self = [super init]) {
        _jsMsgArray = [NSArray array];
        _isHideProcessView = YES;
         
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWeb];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (NSString *name in self.jsMsgArray) {
        [self.wkWeb.configuration.userContentController removeScriptMessageHandlerForName:name];
    }
    [self.wkWeb removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWeb removeObserver:self forKeyPath:@"title"];
}

-(void)dealloc{
    NSLog(@"%@-had dealloc",NSStringFromClass([self class]));
}

#pragma mark - public function
-(void)addJSMsgWithArray:(NSArray *)arr{
    self.jsMsgArray = arr;
    for (NSString *name in arr) {
        [self.wkWeb.configuration.userContentController addScriptMessageHandler:self name:name];
    }
}

-(void)loadrequestWithStr:(NSString *)str{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [self.wkWeb loadRequest:req];
}

-(void)handleJsMsgWith:(id)msg{
    NSAssert(NO, @"need to overwrite!");
}

//-------------- oc 调用 js方法 --------------//
-(void)sendSuccessWithFuntion:(NSString *)fun andData:(NSDictionary *)dic {
    //NSDictionary *data = @{@"fun":fun, @"data":dic?dic:@""};
    //NSString * jsStr = [NSString stringWithFormat:@"uroadplus_fun_success('%@')",data.jsonStringEncoded];
    //[self sendFuntionToH5WithJSString:jsStr];
}
-(void)sendFailWithFuntion:(NSString *)fun andData:(NSDictionary *)dic {
    //NSDictionary *data = @{@"fun":fun, @"data":dic?dic:@""};
    //NSString * jsStr = [NSString stringWithFormat:@"uroadplus_fun_fail('%@')",data.jsonStringEncoded];
    //[self sendFuntionToH5WithJSString:jsStr];
    
}
-(void)sendCompleteWithFuntion:(NSString *)fun andData:(NSDictionary *)dic {
   //NSDictionary *data = @{@"fun":fun, @"data":dic?dic:@""};
    //NSString * jsStr = [NSString stringWithFormat:@"uroadplus_fun_complete('%@')",data.jsonStringEncoded];
    //[self sendFuntionToH5WithJSString:jsStr];
}


#pragma mark - private function
-(void)initWKWeb{
    if (self.wkWeb) {
        [self.wkWeb removeFromSuperview];
    }
    //初始化一个WKWebViewConfiguration对象
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    //初始化偏好设置属性：preferences
    config.preferences = [WKPreferences new];
    //The minimum font size in points default is 0;
    config.preferences.minimumFontSize = 10;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    
    //以下代码适配文本大小
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //用于进行JavaScript注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [config.userContentController addUserScript:wkUScript];
    self.config = config;
    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    wkWeb.UIDelegate = self;
    wkWeb.navigationDelegate = self;
    //监听进度条和标题
    [wkWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [wkWeb addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:wkWeb];
    self.wkWeb = wkWeb;
}

- (void)getCookie{
    //取出cookie
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString =
    @"function setCookie(name,value,expires)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }\
    function getCookie(name)\
    {\
    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
    if(arr != null) return unescape(arr[2]); return null;\
    }\
    function delCookie(name)\
    {\
    var exp = new Date();\
    exp.setTime(exp.getTime() - 1);\
    var cval=getCookie(name);\
    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
    }";
    
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        [JSCookieString appendString:excuteJSString];
    }
    //执行js
    [self.wkWeb evaluateJavaScript:JSCookieString completionHandler:nil];
}

- (void)sendFuntionToH5WithJSString:(NSString *)jsStr {
    [self.wkWeb evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWeb && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.progressView.alpha = 1.0f;
        [self.progressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                self.progressView.alpha = 0.0f;
            }
                             completion:^(BOOL finished) {
                [self.progressView setProgress:0 animated:NO];
            }];
        }
        
    }else if (object == self.wkWeb && [keyPath isEqualToString:@"title"]) {
         
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - wkWebDelegate
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    //[self getCookie];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView != self.wkWeb) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    //需要跳转再做处理
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - JSMessageHandler ---- JS to OC
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString * jsonString = message.body;
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//    [self handleJsMsgWith:message];
}


#pragma mark - setter/getter
-(UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, self.navigationController.toolbar.frame.size.height + 40, [UIScreen mainScreen].bounds.size.width, 0)];
        _progressView.tintColor = UIColor.blueColor;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

-(void)setIsHideProcessView:(BOOL)isHideProcessView{
    _isHideProcessView = isHideProcessView;
    isHideProcessView?:[self.view addSubview:self.progressView];
}

@end
