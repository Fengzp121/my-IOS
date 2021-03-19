//
//  FFTableViewCell.m
//  videoEditTest
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FFTableViewCell.h"
#import "FFTableCellModel.h"
#import "FFTableViewCellImageView.h"
#import "FFTableCellToolBar.h"
@interface FFTableViewCell()


@property (nonatomic,weak)UIImageView *userImage;           //头像
@property (nonatomic,weak)UILabel *userName;                //用户名
@property (nonatomic,weak)UILabel *sendTimeLabel;           //发表时间
@property (nonatomic,weak)UILabel *device_or_origin;       //设备属性或者发布来源
 
@property (nonatomic,weak)UILabel *textPostLabel;           //文字内容

@property (nonatomic,weak)FFTableViewCellImageView  *ImagecontentView;        //图片的内容或者别的
@property (nonatomic,weak)FFTableCellToolBar *toolBar;                  //每个cell下面的toolbar

@property (nonatomic,weak)UIView *bottomLine;
@end


@implementation FFTableViewCell

static const CGFloat margin = 8.0;

- (void)setModel:(FFTableCellModel *)model{
    _model = model;
    self.userImage.image = model.avatarImage;
    self.userName.text   = model.userName;
    self.sendTimeLabel.text = model.sendTime;
    self.device_or_origin.text = model.device_or_version;
    self.textPostLabel.text = model.contentLabel;
    self.toolBar.model = model;
    [self.textPostLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.postlabelHeight);
    }];
    [self layoutIfNeeded];
}

#pragma mark - lazy load
-(FFTableCellToolBar *)toolBar{
    if(_toolBar == nil){
        FFTableCellToolBar *toolBar = [[FFTableCellToolBar alloc] init];
        [self.contentView addSubview:toolBar];
        _toolBar = toolBar;
        toolBar.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.mas_equalTo(self.bottomLine.mas_top);
            make.height.offset(32.5);
        }];
    }
    return _toolBar;
}

-(UIView *)bottomLine{
    if (_bottomLine == nil) {
        UIView *bottomLine = [[UIView alloc] init];
        [self.contentView addSubview:bottomLine];
        _bottomLine = bottomLine;
        bottomLine.backgroundColor = UIColor.grayColor;
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(8);
        }];
    }
    return _bottomLine;
}


-(FFTableViewCellImageView *)ImagecontentView{
    if(_ImagecontentView == nil){
//        FFTableViewCellImageView *ImagecontentView = [[FFTableViewCellImageView alloc] init];
//        [self.contentView addSubview:ImagecontentView];
//        _ImagecontentView = ImagecontentView;
//        [ImagecontentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.userImage.mas_left);
//            make.top.mas_equalTo(self.textPostLabel.mas_bottom).offset(8);
//            make.size.mas_equalTo(CGSizeMake(80, 80));
//        }];
    }
    return _ImagecontentView;
}

-(UIImageView *)userImage{
    if(_userImage == nil){
        UIImageView *userImage = [[UIImageView alloc] init];
        [self.contentView addSubview:userImage];
        _userImage = userImage;
        userImage.contentMode = UIViewContentModeScaleAspectFill;
        userImage.layer.cornerRadius  = 25;
        userImage.layer.borderColor   = [UIColor lightGrayColor].CGColor;
        userImage.layer.borderWidth   = 1;
        userImage.layer.masksToBounds = YES;
        [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(margin);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }
    return _userImage;
}

-(UILabel *)userName{
    if(_userName == nil){
        UILabel *userName = [[UILabel alloc] init];
        [self.contentView addSubview:userName];
        _userName = userName;
        userName.text = @"fuck!";
        userName.textAlignment = NSTextAlignmentLeft;
        userName.textColor = UIColor.redColor;
        userName.font = [UIFont systemFontOfSize:14];
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userImage.mas_right).offset(8);
            make.top.offset(12);
        }];
    }
    return _userName;
}

-(UILabel *)sendTimeLabel{
    if(_sendTimeLabel == nil){
        UILabel *sendTimeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:sendTimeLabel];
        _sendTimeLabel = sendTimeLabel;
        sendTimeLabel.textAlignment = NSTextAlignmentLeft;
        sendTimeLabel.textColor = UIColor.greenColor;
        sendTimeLabel.font = [UIFont systemFontOfSize:14];
        [sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userImage.mas_right).offset(8);
            make.top.mas_equalTo(self.userName.mas_bottom).offset(5);
        }];
    }
    return _sendTimeLabel;
}

-(UILabel *)device_or_origin{
    if(_device_or_origin == nil){
        UILabel *device_or_origin = [[UILabel alloc] init];
        [self.contentView addSubview:device_or_origin];
        _device_or_origin = device_or_origin;
        device_or_origin.textAlignment = NSTextAlignmentLeft;
        device_or_origin.textColor = UIColor.blueColor;
        device_or_origin.font = [UIFont systemFontOfSize:14];
        [device_or_origin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sendTimeLabel.mas_right).offset(5);
            make.top.mas_equalTo(self.userName.mas_bottom).offset(5);
        }];
    }
    return _device_or_origin;
}


-(UILabel *)textPostLabel{
    if(_textPostLabel == nil){
        UILabel *textPostLabel = [[UILabel alloc] init];
        [self.contentView addSubview:textPostLabel];
        _textPostLabel = textPostLabel;
        textPostLabel.numberOfLines = 0;
        textPostLabel.textAlignment = NSTextAlignmentLeft;
        textPostLabel.textColor = UIColor.blackColor;
        textPostLabel.font = [UIFont systemFontOfSize:14];
        textPostLabel.preferredMaxLayoutWidth = FFScreenWidth - 2 *margin;
        [textPostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(margin);
            make.right.offset(-margin);
            make.top.mas_equalTo(self.userImage.mas_bottom).offset(8);
            make.height.mas_equalTo(20);
        }];
    }
    return _textPostLabel;
}

-(UIView *)testView{
    if(!_testView){
        _testView = [[UIView alloc] init];
        [self.contentView addSubview:_testView];
        _testView.backgroundColor = UIColor.redColor;
        [_testView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(margin);
            make.right.offset(-margin);
            make.top.mas_equalTo(self.textPostLabel.mas_bottom).offset(8);
            make.height.mas_equalTo(20);
        }];
    }
    return _testView;
}



#pragma mark - init
+(instancetype)FFtableViewCellWithTableView:(UITableView *)tableView{
    FFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = UIColor.whiteColor;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
