//
//  FFCrashDemoVC.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/31.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "FFCrashDemoVC.h"
#import "FFCrashHandler.h"

@interface FFCrashDemoVC ()<FFCrashHandlerDelegate>
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, copy)NSString *errorInfo;

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
    [FFCrashHandler defaultCrashHandler].delegate = self;
}

- (void)setUI{
    self.navigationController.title = @"iOS Crash防护😄";
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSArray *methods = @[@"testArray",@"testMArray,testDictionary"];
    NSArray *titles  = @[@"数组越界",@"可变数组越界,字典"];
    CGSize size = CGSizeMake(self.view.mj_w/4.0, 65);
    int i = 0;
    for(NSString *title in titles){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%4*size.width, 88+ i/4*size.height + 10, size.width, size.height)];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.greenColor;
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:NSSelectorFromString(methods[i]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        NSLog(@"btn is created: %@",btn);
        i++;
    }
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 88+ i%4*size.height + 10, self.view.mj_w, self.view.mj_h - (88+ i%4*size.height + 10))];
    self.textView.editable = NO;
    self.textView.text = @"输出结果";
    [self.view addSubview:self.textView];
}

//
-(void)crashHandleDidOutputCrashError:(FFCrashError *)crashError{
    _errorInfo = [NSString stringWithFormat:@"%@\n错误描述：%@ \n 调用栈：%@" ,_errorInfo,crashError.errorDesc, crashError.callStack];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.textView scrollsToTop];
        self.textView.text =  self->_errorInfo;
    });
    //将东西存储下来，数据库或者文件系统都可以//
}

#pragma mark - 测试方法
-(void)testArray{
    //越界
    NSArray *array = @[@"且行且珍惜"];
    id elem1 = array[3];
    id elem2 = [array objectAtIndex:2];
    //nil值
    NSString *nilStr = nil;
    NSArray *array1 = @[nilStr];
    NSString *strings[2];
    strings[0] = @"wsl";
    strings[1] = nilStr;
    NSArray *array2 = [NSArray arrayWithObjects:strings count:2];
    NSArray *array3 = [NSArray arrayWithObject:nil];
}

-(void)testMArray{
    NSMutableArray *mArray = [NSMutableArray array];
    [mArray objectAtIndex:2];
    id nilObj = mArray[2];
    [mArray insertObject:@"wsl" atIndex:1];
    [mArray removeObjectAtIndex:3];
    [mArray insertObjects:@[@"w",@"s",@"l"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 3)]];
    [mArray replaceObjectAtIndex:5 withObject:@"wsl"];
    [mArray replaceObjectAtIndex:5 withObject:nil];
    [mArray replaceObjectsInRange:NSMakeRange(5, 3) withObjectsFromArray:@[@"w",@"s",@"l"]];
    //nil值
    [mArray insertObject:nil atIndex:3];
    NSMutableArray *mArray1 = [NSMutableArray arrayWithObject:nil];
    NSMutableArray *mArray2 = [NSMutableArray arrayWithObject:@[nilObj]];
    [mArray addObject:nilObj];
}

-(void)testDictionary{
    NSString *nilValue = nil;
    NSString *nilKey = nil;
    NSDictionary *dic = @{@"key":nilValue};
    dic = @{nilKey:@"value"};
    [NSDictionary dictionaryWithObject:@"value" forKey:nilKey];
    [NSDictionary dictionaryWithObject:nilValue forKey:@"key"];
    [NSDictionary dictionaryWithObjects:@[@"w",@"s",@"l"] forKeys:@[@"1",@"2",nilKey]];
}

-(void)testmDictionary{
    NSString *nilValue = nil;
    NSString *nilKey = nil;
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setValue:nilValue forKey:@"key"];
    [mDict setValue:@"value" forKey:nilKey];
    [mDict setValue:nilValue forKey:nilKey];
    [mDict removeObjectForKey:nilKey];
    mDict[nilKey] = nilValue;
    NSMutableDictionary *mDict1 = [NSMutableDictionary dictionaryWithDictionary:@{nilKey:nilValue}];
}



@end
