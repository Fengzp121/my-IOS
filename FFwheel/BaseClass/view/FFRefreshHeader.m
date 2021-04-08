//
//  FFRefreshHeaher.m
//  videoEditTest
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFRefreshHeader.h"

@implementation FFRefreshHeader
//asd
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.automaticallyChangeAlpha = YES;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
     self.automaticallyChangeAlpha = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)endRefreshing{
    [super endRefreshing];
    self.state = MJRefreshStateIdle;
}

@end
