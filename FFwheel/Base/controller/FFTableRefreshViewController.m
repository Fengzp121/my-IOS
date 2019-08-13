//
//  FFTableRefreshViewController.m
//  videoEditTest
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTableRefreshViewController.h"

@interface FFTableRefreshViewController ()

@end

@implementation FFTableRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    weak(weakSelf)
//    self.tableView.mj_header = [FFRefreshHeader headerWithRefreshingBlock:^{
//         [weakSelf canRefresh:NO];
//    }];
//    self.tableView.mj_footer = [FFRefreshAutoFooter footerWithRefreshingBlock:^{
//         [weakSelf canRefresh:YES];
//    }];
//    [self.tableView.mj_header beginRefreshing];
    
}

-(void)canRefresh:(BOOL)is{
    if(is){
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = NO;
    }else
    {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = NO;
        self.tableView.mj_footer.hidden = YES;
    }
    [self setModelValue:is];
}

-(void)setModelValue:(BOOL)is{
    //子类重载
    NSLog(@"fuck");
}


-(void)endHeaderFooterRefreshing{
    NSLog(@"---FFTableRefreshViewController.h---结束更新");
    if([self.tableView.mj_header isRefreshing]) return [self.tableView.mj_header endRefreshing];
    if([self.tableView.mj_footer isRefreshing]) return [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
}
@end
