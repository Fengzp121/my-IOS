//
//  FFTableRefreshViewController.h
//  videoEditTest
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTableViewController.h"
#import "FFRefreshAutoFooter.h"
#import "FFRefreshHeader.h"

@interface FFTableRefreshViewController : FFTableViewController

-(void)setModelValue:(BOOL)is;

// 结束刷新, 子类请求报文完毕调用
-(void)endHeaderFooterRefreshing;

@end


