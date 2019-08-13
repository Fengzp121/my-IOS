//
//  FFTableCellToolBar.m
//  videoEditTest
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTableCellToolBar.h"
#import "FFTableCellModel.h"
@interface FFTableCellToolBar()
@property (strong, nonatomic) UIView *toolBarView;

@property (weak, nonatomic)  UIButton *ShareButton;
@property (weak, nonatomic)  UIButton *LikeButton;
@property (weak, nonatomic)  UIButton *composeButton;

 
@end
@implementation FFTableCellToolBar



-(void)setModel:(FFTableCellModel *)model{
    _model = model;
    [self.LikeButton setTitle:model.likeCount forState:UIControlStateNormal];
    [self.ShareButton setTitle:model.sharCount forState:UIControlStateNormal];
    [self.composeButton setTitle:model.composeCount forState:UIControlStateNormal];
}



-(void)layoutSubviews{
    [super layoutSubviews];
    [self.ShareButton setImage:[UIImage imageNamed:@"countBtn"] forState:UIControlStateNormal];
    [self.LikeButton setImage:[UIImage imageNamed:@"countBtn"] forState:UIControlStateNormal];
    [self.composeButton setImage:[UIImage imageNamed:@"countBtn"] forState:UIControlStateNormal];
}


-(UIView *)toolBarView{
    if(_toolBarView == nil){
        _toolBarView = [[UIView alloc] init];
        [self addSubview:_toolBarView];
        [_toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.mas_equalTo(32);
        }];
    }
    return _toolBarView;
}

-(UIButton *)LikeButton{
    if(_LikeButton == nil){
        UIButton *LikeButton = [[UIButton alloc] init];
        [self addSubview:LikeButton];
        _LikeButton = LikeButton;
        [LikeButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [LikeButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
        [LikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(40);
            make.height.mas_equalTo(32);
        }];
    }
    return _LikeButton;
}

-(UIButton *)ShareButton{
    if(_ShareButton == nil){
        UIButton *ShareButton = [[UIButton alloc] init];
        [self addSubview:ShareButton];
        _ShareButton = ShareButton;
        [ShareButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [ShareButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
        [ShareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.LikeButton.mas_right).offset(76);
            make.height.mas_equalTo(32);
        }];
    }
    return _ShareButton;
}

-(UIButton *)composeButton{
    if(_composeButton == nil){
        UIButton *composeButton = [[UIButton alloc] init];
        [self addSubview:composeButton];
        _composeButton = composeButton;
        [composeButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [composeButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
        [_composeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.ShareButton.mas_right).offset(76);
            make.height.mas_equalTo(32);
        }];
    }
    return _composeButton;
}

-(void)clickBtn:(UIButton *)sender{
    NSLog(@"---ffffffff---:clickBtn");
}

@end
