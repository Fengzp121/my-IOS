//
//  FFTableCellModel.m
//  videoEditTest
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTableCellModel.h"

@implementation FFTableCellModel

+(instancetype)setModelValue{

    FFTableCellModel *model = [[self alloc] init];
    model.userName = @"fffuck";
    model.avatarImage = [UIImage imageNamed:@"avatar"];
    model.sendTime = @"2018-1-1";
    model.device_or_version = @"fuck X";
    model.contentLabel = @"fukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuckfukcfuckfuckfuck";
    
    [model.imageArray addObject:model.avatarImage.images];
    [model.imageArray addObject:model.avatarImage.images];

    model.likeCount    = @"999";
    model.composeCount = @"999";
    model.sharCount    = @"999";
    return model;
}

-(CGFloat)cellHeight{
    if(_cellHeight == 0){
        const CGFloat userImageHeight = 58;
        _cellHeight +=userImageHeight;
        _cellHeight += 58;
        _cellHeight += self.postlabelHeight;
        _cellHeight += self.imageArrayHeight;
    }
    return _cellHeight;
}

-(CGFloat)postlabelHeight{
    if(_postlabelHeight == 0){
        CGSize textSize = CGSizeMake(FFScreenWidth - 2 * 8 ,INFINITY);
        _postlabelHeight = ceilf([self.contentLabel boundingRectWithSize:textSize options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height);
        
        
        
    }
    return _postlabelHeight;
}

-(CGFloat)imageArrayHeight{
    if(_imageArrayHeight == 0){
         
        _imageArrayHeight +=80;
    }
    return _imageArrayHeight;
}
@end
