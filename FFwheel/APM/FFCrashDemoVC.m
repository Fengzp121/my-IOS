//
//  FFCrashDemoVC.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "FFCrashDemoVC.h"
#import "FFCrashHandle.h"

@interface FFCrashDemoVC ()<FFCrashHandleDelegate>
@property(nonatomic, strong)UITextView *textView;


//@property (nonatomic, copy) void(^testBlock)(void); //测试循环引用
//@property (nonatomic, strong) NSMutableArray *testMArray; //测试循环引用
//未实现的实例方法
//- (id)undefineInstanceMethodTest:(id)sender;
//未实现的类方法
//+ (id)undefineClassMethodTest:(id)sender;

@end

@implementation FFCrashDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [FFCrashHandle defaultCrashHandler].delegate = self;
}

- (void)setUI{
    self.navigationController.title = @"iOS Crash防护😄";
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSArray *methods = @[@"testArrayOutofRange"];
    NSArray *titles  = @[@"数组越界"];
    CGSize size = CGSizeMake(self.view.mj_w/4.0, 65);
    int i = 0;
    for(NSString *title in titles){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%4*size.width, 188+ i/4*size.height, size.width, size.height)];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.greenColor;
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        btn.layer.cornerRadius = 10;
//        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:NSSelectorFromString(methods[i]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        i++;
    }
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 188+ i/4*size.height, self.view.mj_w, self.view.mj_h - (188+ i/4*size.height))];
    self.textView.editable = NO;
    self.textView.text = @"输出结果";
    [self.view addSubview:self.textView];
}

//
-(void)crashHandleDidOutputCrashError:(FFCrashError *)crashError{
    NSString *errorInfo = [NSString stringWithFormat:@" 错误描述：%@ \n 调用栈：%@" ,crashError.errorDesc, crashError.callStack];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.textView scrollsToTop];
        self.textView.text =  errorInfo;
    });
    //将东西存储下来，数据库或者文件系统都可以//
}

//测试方法
-(void)testArrayOutofRange{
    NSArray *arr = @[@"1",@"2"];
    NSString *t = [arr objectAtIndex:2];
}




@end
