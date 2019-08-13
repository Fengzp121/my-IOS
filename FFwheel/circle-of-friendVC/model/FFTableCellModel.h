//
//  FFTableCellModel.h
//  videoEditTest
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

 

@interface FFTableCellModel : NSObject

+(instancetype)setModelValue;
//cell属性
@property (nonatomic,strong) UIImage *avatarImage;
@property (nonatomic,copy)  NSString *userName;
@property (nonatomic,copy)  NSString *sendTime;
@property (nonatomic,copy)  NSString *device_or_version;
@property (nonatomic,copy)  NSString *contentLabel;
@property (nonatomic,assign)  NSMutableArray *imageArray;

//toolBar
@property (nonatomic,copy) NSString *likeCount;
@property (nonatomic,copy) NSString *composeCount;
@property (nonatomic,copy) NSString *sharCount;

@property (nonatomic,assign)CGFloat postlabelHeight;
@property (nonatomic,assign)CGFloat imageArrayHeight;
@property (nonatomic,assign)CGFloat cellHeight;
@end

 
