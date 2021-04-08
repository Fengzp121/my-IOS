//
//  baseClass.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/3.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "baseClass.h"

@interface baseClass ()
-(void)printNN;
@end

@implementation baseClass

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self printNN];
}

-(void)printNN{}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
