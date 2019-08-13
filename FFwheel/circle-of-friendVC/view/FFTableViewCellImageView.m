//
//  FFTableViewCellImageView.m
//  videoEditTest
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTableViewCellImageView.h"
#import "FFTableCellModel.h"
@interface FFTableViewCellImageView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak)UICollectionView *collectionView;

@property (nonatomic, assign)NSMutableArray *imageArray;

@end
@implementation FFTableViewCellImageView

-(void)setModel:(FFTableCellModel *)model{
    _model = model;
    [self.collectionView reloadData];
}

#pragma mark -lazy load
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionView *collectionView = [UICollectionView new];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
        collectionView.collectionViewLayout = layout;
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled = NO;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return _collectionView;
}


#pragma mark - UIcollectionDelegate,UIcollectionDatasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击collectioncell");
}

#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.redColor;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = UIColor.whiteColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end


@implementation FFImageCollectionViewCell

-(UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return _imageView;
}

@end
