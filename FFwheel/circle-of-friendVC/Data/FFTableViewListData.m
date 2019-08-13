//
//  FFTableViewListData.m
//  videoEditTest
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTableViewListData.h"

@implementation FFTableViewListData

-(void)getModelBlock:(void (^)(NSError *))completion{
     FFTableCellModel *model = [FFTableCellModel setModelValue];
        for (int i = 0; i < 10; i++) {
            [_listData addObject:model];
            NSLog(@"%@",_listData[i]);
//            [self setlistData:_listData complation:^(NSError *error, NSMutableArray<FFTableCellModel *> *model) {
//
//            }];
        }
    
    completion(nil);
}

-(void)setlistData:(NSMutableArray<NSMutableDictionary*> *)dictionary complation:(void(^)(NSError *error,NSMutableArray<FFTableCellModel *> *model))complation{
    //NSMutableArray<FFTableCellModel *> *model = [NSMutableArray array];
    
}

-(NSMutableArray<FFTableCellModel *> *)listData{
    if(_listData == nil){
        _listData = [NSMutableArray array];
    }
    return _listData;
}

@end
