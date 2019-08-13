//
//  FFTableViewListData.h
//  videoEditTest
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//


#import "FFTableCellModel.h"


@interface FFTableViewListData : NSObject

 
@property (nonatomic,strong)NSMutableArray<FFTableCellModel *> *listData;

-(void)getModelBlock:(void(^)(NSError *error))completion;

@end


