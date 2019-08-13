//
//  FFTabBarController.m
//  FFwheel
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTabBarController.h"
#import "FFTabBarView.h"
#import "FFBlockTest.h"
@interface FFTabBarController ()<UITabBarControllerDelegate>

@end

@implementation FFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setTabBar];
    [self addChildViewController];
    [self addTabBarItems];
}

-(void)setTabBar{
    FFTabBarView *tabBar = [[FFTabBarView alloc] init];
    [tabBar setCenterBtn:^(FFTabBarView *tab, UIButton *centerBtn) {
        NSLog(@"centerBtn");
    }];
}

-(void)addChildViewController{
    FFNavigationViewController *one = [[FFNavigationViewController alloc] initWithRootViewController:[FFBlockTest new]];
    FFNavigationViewController *two = [[FFNavigationViewController alloc] initWithRootViewController:[FFBlockTest new]];
    FFNavigationViewController *third = [[FFNavigationViewController alloc] initWithRootViewController:[FFBlockTest new]];
    FFNavigationViewController *four = [[FFNavigationViewController alloc] initWithRootViewController:[FFBlockTest new]];
    self.viewControllers = @[one,two,third,four];
}

-(void)addTabBarItems{
    NSDictionary *oneItemAttributes = @{
                                        @"TabBarItemTitle":@"one",
                                        @"TabBarItemImage":@"countBtn",
                                        };
    NSDictionary *twoItemAttributes = @{
                                        @"TabBarItemTitle":@"two",
                                        @"TabBarItemImage":@"countBtn",
                                        };
    NSDictionary *thirdItemAttributes = @{
                                        @"TabBarItemTitle":@"third",
                                        @"TabBarItemImage":@"countBtn",
                                        };
    NSDictionary *fourItemAttributes = @{
                                        @"TabBarItemTitle":@"four",
                                        @"TabBarItemImage":@"countBtn",
                                        };
    NSArray<NSDictionary *> *tabBarItem = @[oneItemAttributes,twoItemAttributes,thirdItemAttributes,fourItemAttributes];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = tabBarItem[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [UIImage imageNamed:tabBarItem[idx][@"TabBarItemImage"]];
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }];
    self.tabBar.tintColor = UIColor.orangeColor;
    self.tabBar.unselectedItemTintColor = UIColor.darkTextColor;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
@end
