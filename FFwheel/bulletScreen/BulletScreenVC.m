//
//  BulletScreenVC.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/18.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "BulletScreenVC.h"
#import "TextToImageTool.h"
#import <Masonry/Masonry.h>
@interface BulletScreenVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton *doneButton;
@end

@implementation BulletScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _textField = [[UITextField alloc ]init];
    _textField.delegate = self;
    _textField.backgroundColor = UIColor.darkGrayColor;
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(80);
        make.centerX.equalTo(self.view);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
    _imageView = [[UIImageView alloc] init];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textField.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.offset(300);
        make.height.offset(300);
    }];
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *text = textField.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        UIImage *image = [TextToImageTool zd_imageWithColor:UIColor.whiteColor size:CGSizeMake(50, 150) text:text textAttributes:attributes];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_imageView.image = image;
        });
    });
    return YES;
}

@end
