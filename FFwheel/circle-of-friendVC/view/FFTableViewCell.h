//
//  FFTableViewCell.h
//  videoEditTest
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//


@class FFTableCellModel;
 
@interface FFTableViewCell : UITableViewCell

@property (nonatomic,strong)NSDictionary *celldata;

+(instancetype)FFtableViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)FFTableCellModel *model;

@property (nonatomic,strong) void(^ClickAvatar)(UIImageView *userImage);

@end



