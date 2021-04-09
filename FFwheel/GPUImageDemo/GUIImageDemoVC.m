//
//  GUIImageDemoVC.m
//  FFwheel
//
//  Created by ffzp on 2021/3/30.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "GUIImageDemoVC.h"

#import "FaceDetectCameraVC.h"
#import "BeautyCameraVC.h"

@interface GUIImageDemoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@end

//TODO:然后就看看opencv和face++读取出来的点是什么情况
//TODO:如果不行就用face++的作为基准去做美颜了

@implementation GUIImageDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@{@"title":@"人脸特征点检测",@"func":@"faceDetect"},
                        @{@"title":@"美颜",@"func":@"beautyCamera"}];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.offset(SafeNavigatorTop);
    }];
}

#pragma mark - Actions
- (void)faceDetect{
    [self.navigationController pushViewController:[FaceDetectCameraVC new] animated:YES];
}

- (void)beautyCamera{
    [self.navigationController pushViewController:[BeautyCameraVC new] animated:YES];
}


#pragma mark - TableView Delegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = self.dataSource[indexPath.row][@"title"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *funcStr = self.dataSource[indexPath.row][@"func"];
    SEL selector = NSSelectorFromString(funcStr);
    [self performSelector:selector];
}

@end
