//
//  privateView.h
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/3.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol privateViewDelegate <NSObject>

-(void)clickOkButton;

@end
@interface privateView : UIView
@property (weak, nonatomic) id<privateViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (copy , nonatomic) NSString * contentLabelText;
+(void)show;
@end

NS_ASSUME_NONNULL_END
