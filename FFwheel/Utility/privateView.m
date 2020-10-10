//
//  privateView.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/3.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "privateView.h"
#import <Masonry/Masonry.h>
@interface privateView()


@end



@implementation privateView
+(void)show{
    
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
//    }];
    NSLog(@"clear？");
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.text = @"隐私保护协议";
    self.contentLabel.text = @"-(instancetype)init{self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];if(self){}return self;}nstancetype)init{self = [super initWithNibName:NSStringFromClass([self class]nstancetype)init{self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];if(self){}return self;}nstancetype)init{self = [super initWithNibName:NSStringFromClass(";
}

- (IBAction)clickOKButton:(UIButton *)sender {
    
    for(UIView * next = self; next ; next = next.superview){
        UIResponder *nextResponder = [next nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]){
            UIViewController *vc = (UIViewController *)nextResponder;
            for (UIView *view in vc.view.subviews) {
                if ([view isKindOfClass:[privateView class]]) {
                    [view removeFromSuperview];
                }
            }
        }
    }
    
    
    //    if([self.delegate respondsToSelector:@selector(clickOkButton)]){
    //        [self.delegate clickOkButton];
    //    }
}


@end
