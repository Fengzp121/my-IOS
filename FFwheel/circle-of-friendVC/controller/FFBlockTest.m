//
//  FFBlockTest.m
//  videoEditTest
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFBlockTest.h"
#import "FFTableViewCell.h"
#import "FFTableCellModel.h"
#import "FFTableViewListData.h"


@interface FFBlockTest() 

@property (nonatomic,strong)FFTableViewListData *listdata;

@end

@implementation FFBlockTest

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUI];
}



-(void)setUI{
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"fuck";
    [self endHeaderFooterRefreshing];
}

-(void)setModelValue:(BOOL)is{
    
}


#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FFTableViewCell *cell = [FFTableViewCell FFtableViewCellWithTableView:tableView];
    FFTableCellModel *newModel = [FFTableCellModel setModelValue];
    cell.model = newModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FFTableViewCell *cell = [FFTableViewCell FFtableViewCellWithTableView:tableView];
    FFTableCellModel *newModel = [FFTableCellModel setModelValue];
    cell.model = newModel;
    return cell.model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark -action
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scanBigImage{
    NSLog(@"放大图片");
    
}

-(void)scanImage:(UIImageView *)sender{
    
}

#pragma mark -lazy load

-(FFTableViewListData *)listdata{
    if (_listdata == nil) {
        _listdata = [FFTableViewListData new];
    }
    return _listdata;
}


@end
