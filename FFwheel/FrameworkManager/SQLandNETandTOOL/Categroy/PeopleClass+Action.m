//
//  PeopleClass+Action.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/6.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "PeopleClass+Action.h"


static const void* ACTION_ARR_KEY = &ACTION_ARR_KEY;

@implementation PeopleClass (Action)
-(void)setActionArr:(NSMutableArray *)actionArr{
    objc_setAssociatedObject(self, ACTION_ARR_KEY, actionArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)actionArr{
    NSMutableArray *arr = objc_getAssociatedObject(self, ACTION_ARR_KEY);
    return arr;
}

@end
