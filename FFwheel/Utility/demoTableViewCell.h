//
//  demoTableViewCell.h
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/2.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface demoTableViewCell : UITableViewCell
@property (nonatomic,copy) NSString * titleModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIImageView *atavarImg;
 
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@end

NS_ASSUME_NONNULL_END
