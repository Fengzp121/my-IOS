//
//  DemoViewController.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/2.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "DemoViewController.h"
#import "demoLabel.h"
#import "demoTableView.h"
#import "demoTableViewCell.h"
@interface DemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet demoLabel *titleL;
@property (weak, nonatomic) IBOutlet demoTableView *tablev;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *successButton;

@property (strong,nonatomic) NSMutableArray *model;

@property (nonatomic, strong)NSMutableArray *selectArray;
@end

@implementation DemoViewController
-(instancetype)init{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if(self){

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectArray = [NSMutableArray array];
    [self.tablev registerNib:[UINib nibWithNibName:@"demoTableViewCell" bundle:nil] forCellReuseIdentifier:@"demoTableViewCell"];
    self.textLabel.text = @"-(instancetype)init{self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];if(self){}return self;}nstancetype)init{self = [super initWithNibName:NSStringFromClass([self class]ingFromClass([self class]) bundle:nil];if(self){}return self;}nstancetype)init{self = [super initWithNibName:NSStringFromCla";
    _model = [NSMutableArray array];
    //for (int i = 0; i < 10; i++ ) {
    [_model addObject:@"-(inhN:ass([self class]"];
    [_model addObject:@"-(ilf r initWithNibName:NSStringFromClass([self class]"];
    [_model addObject:@"-(instalass]"];
    [_model addObject:@"-(instClass([self class]) bundle:nil];if(self){}return self;}nstancetype)init{self = [super initWithNibName:NSStringFromClass([self class]"];
    [_model addObject:@"-(instan)init{self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];if(self){}return self;}nstancetype)init{self = [super initWithNibName:NSStringFromClass([self class]"];
    [_model addObject:@"-(instancetype)init{self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];if(self){}return self;}nstancetype)init{self = [super initWithNibName:NSStringFromClass([self class]"];
    //}
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    demoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoTableViewCell"];
    cell.titleModel = _model[indexPath.row];
    //[self.selectArray containsObject:[NSString stringWithFormat:@"%li",indexPath.row]]
    
    if ([self.selectArray containsObject:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        [cell.selectImg setImage:[UIImage imageNamed:@"selected"]];
    }else{
        [cell.selectImg setImage:[UIImage imageNamed:@"noselect"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"nothing happen");
    //if(self.selectArray[indexPath.r])
    demoTableViewCell *cell = (demoTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //demoTableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
    //    cell.selectBtn.isSelected?[cell.selectBtn setTitle:@"未选" forState:UIControlStateNormal]:[cell.selectBtn setTitle:@"已选" forState:UIControlStateNormal];
    //    cell.selectBtn.selected = !cell.selectBtn.isSelected;
    //    [tableView reloadData];
    if([self.selectArray containsObject:[NSString stringWithFormat:@"%li",indexPath.row]]){
        [self.selectArray removeObject:[NSString stringWithFormat:@"%li",indexPath.row]];
        [cell.selectImg setImage:[UIImage imageNamed:@"noselect"]];
    }else{
        [self.selectArray addObject:[NSString stringWithFormat:@"%li",indexPath.row]];
        [cell.selectImg setImage:[UIImage imageNamed:@"selected"]];
    }
    [self.tablev reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
