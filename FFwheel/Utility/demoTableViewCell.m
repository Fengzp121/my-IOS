//
//  demoTableViewCell.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/2.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "demoTableViewCell.h"

@implementation demoTableViewCell

-(void)setTitleModel:(NSString *)titleModel{
    self.selectImg.hidden = NO;
    self.titleLabel.text = @"1111";
    self.contentL.text = titleModel;
    self.atavarImg.image = [UIImage imageNamed:@"1111"];
    _titleModel = titleModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectImg.hidden = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
 
@end
