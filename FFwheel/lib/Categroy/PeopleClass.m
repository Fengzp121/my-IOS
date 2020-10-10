//
//  PeopleClass.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/6.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "PeopleClass.h"
#import "PeopleClass+Action.h"
@implementation PeopleClass
-(void)peopleDoSomething{
    self.actionArr = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [self.actionArr addObject:[NSString stringWithFormat:@"run:%i",i]];
    }
    for (int i = 0; i < 5; i++) {
        NSLog(@"myActionArr:%@",self.actionArr[i]);
    }
}
@end
