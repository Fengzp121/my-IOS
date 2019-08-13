//
//  FFTableViewCellImageView.h
//  videoEditTest
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//


@class FFTableCellModel;
@interface FFTableViewCellImageView : UIView

@property (nonatomic,strong)FFTableCellModel *model;

@end

@interface FFImageCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak)UIImageView *imageView;

@end
 
