//
//  ImageApiTestViewController.m
//  FFwheel
//
//  Created by ffzp on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ImageApiTestViewController.h"
#import "TZImagePickerController.h"
@interface ImageApiTestViewController ()<TZImagePickerControllerDelegate>
@property (nonatomic,weak)UIButton *APIcheckBtn;            //测试借口
@property (nonatomic,weak)UIButton *PickImageBtn;           //进入picker界面
@property (nonatomic,weak)UIButton *MixAPIcheckBtn;         //混合测试借口
@property (nonatomic,weak)UIButton *DownLoadAPIcheckBtn;    //下载测试借口
@property (nonatomic,weak)UIImageView *loadImageView;       //加载图片的View
@property (nonatomic, strong) NSMutableArray *dataArr;      //图片数组
@end

@implementation ImageApiTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self APIcheckBtn];
    [self PickImageBtn];
    [self loadImageView];
    [self MixAPIcheckBtn];
    [self DownLoadAPIcheckBtn];
}

-(void)setModel{
    if(self.dataArr.count != 0){    self.loadImageView.image = self.dataArr[0];}
}

-(void)ImageviewTapped:(UITapGestureRecognizer*)tap
{
    //[self setModel];
    //保存图片的操作
    UIImageWriteToSavedPhotosAlbum(self.loadImageView.image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);

}

-(void)APICheckBtnClick{
        [[FFdataEngine sharedInstance] ImageUploadApi:self imageArray:self.dataArr requesBlock:^(id data, int code, NSString *message) {
            if(code == CorrectCode){
                NSLog(@"-----上传成功-----message:%@",message);
                NSLog(@"code:%@",[data mj_JSONString]);
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"-----上传失败-----error:%@",error);
        }];
}

-(void)PickIamgeBtnClick{
    [self.dataArr removeAllObjects];
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    vc.allowPickingOriginalPhoto =YES;
    vc.allowPickingVideo = YES;
    //TZImagePickerController *vc2 = [[TZImagePickerController alloc]initwithmax]
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)MixAPICheckBtnClick{
    [[FFdataEngine sharedInstance] Image_Content_uploadApi:self content:@"fuck you!" imageArray:self.dataArr requesBlock:^(id data, int code, NSString *message) {
        if(code == CorrectCode){
            NSLog(@"-----上传成功-----message:%@",message);
            NSLog(@"code:%@",[data mj_JSONString]);
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"-----上传失败-----error:%@",error);
    }];
}

-(void)DownLoadAPICheckBtnClick{
    [self.dataArr removeAllObjects];
    weak(weakSelf)
    [[FFdataEngine sharedInstance]Image_DownloadApi:self requesBlock:^(id data, int code, NSString *message) {
        if(code == CorrectCode){
            NSDictionary *dic_data = [data mj_JSONObject];
            NSString *str = [dic_data objectForKey:@"imageUrl"];
            NSString *content = [dic_data objectForKey:@"content"];
            str = [NSString stringWithFormat:@"http://%@",str];
            NSLog(@"Url:%@\ncontent:%@",str,content);
            NSLog(@"-----下载成功-----message:%@",message);
            [weakSelf.loadImageView sd_setImageWithURL:[NSURL URLWithString:str]];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"-----下载失败-----error:%@",error);
    }];
}


// 保存图片完成
- (void)savedPhotoImage:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        // 保存失败
        NSLog(@"保存失败");
    } else {
        // 保存成功
        NSLog(@"保存成功");
    }
}



-(UIButton *)APIcheckBtn{
    if (_APIcheckBtn == nil) {
        UIButton *APICheckBtn = [[UIButton alloc] init];
        [self.view addSubview:APICheckBtn];
        _APIcheckBtn = APICheckBtn;
        APICheckBtn.backgroundColor = UIColor.whiteColor;
        APICheckBtn.layer.borderWidth = 1;
        APICheckBtn.layer.cornerRadius = 5;
        [APICheckBtn setTitle:@"upload" forState:UIControlStateNormal];
        [APICheckBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        APICheckBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [APICheckBtn addTarget:self action:@selector(APICheckBtnClick) forControlEvents:UIControlEventTouchDown];
        [APICheckBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.offset(118);
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.2);
            make.height.offset(50);
        }];
    }
    return _APIcheckBtn;
}

-(UIButton *)PickImageBtn{
    if (_PickImageBtn == nil) {
        UIButton *PickImageBtn = [[UIButton alloc] init];
        [self.view addSubview:PickImageBtn];
        _PickImageBtn = PickImageBtn;
        PickImageBtn.backgroundColor = UIColor.whiteColor;
        PickImageBtn.layer.borderWidth = 1;
        PickImageBtn.layer.cornerRadius = 5;
        [PickImageBtn setTitle:@"picker" forState:UIControlStateNormal];
        [PickImageBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        PickImageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [PickImageBtn addTarget:self action:@selector(PickIamgeBtnClick) forControlEvents:UIControlEventTouchDown];
        [PickImageBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.2);
            make.height.offset(50);
            make.top.mas_equalTo(self.APIcheckBtn.mas_bottom).offset(10);
        }];
    }
    return _PickImageBtn;
}

-(UIButton *)MixAPIcheckBtn{
    if (_MixAPIcheckBtn == nil) {
        UIButton *MixAPIcheckBtn = [[UIButton alloc] init];
        [self.view addSubview:MixAPIcheckBtn];
        _MixAPIcheckBtn = MixAPIcheckBtn;
        MixAPIcheckBtn.backgroundColor = UIColor.whiteColor;
        MixAPIcheckBtn.layer.borderWidth = 1;
        MixAPIcheckBtn.layer.cornerRadius = 5;
        [MixAPIcheckBtn setTitle:@"MixTest" forState:UIControlStateNormal];
        [MixAPIcheckBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        MixAPIcheckBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [MixAPIcheckBtn addTarget:self action:@selector(MixAPICheckBtnClick) forControlEvents:UIControlEventTouchDown];
        [MixAPIcheckBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.loadImageView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.2);
            make.height.offset(50);
        }];
    }
    return _MixAPIcheckBtn;
}

-(UIButton *)DownLoadAPIcheckBtn{
    if (_DownLoadAPIcheckBtn == nil) {
        UIButton *DownLoadAPIcheckBtn = [[UIButton alloc] init];
        [self.view addSubview:DownLoadAPIcheckBtn];
        _DownLoadAPIcheckBtn = DownLoadAPIcheckBtn;
        DownLoadAPIcheckBtn.backgroundColor = UIColor.whiteColor;
        DownLoadAPIcheckBtn.layer.borderWidth = 1;
        DownLoadAPIcheckBtn.layer.cornerRadius = 5;
        [DownLoadAPIcheckBtn setTitle:@"Download" forState:UIControlStateNormal];
        [DownLoadAPIcheckBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        DownLoadAPIcheckBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [DownLoadAPIcheckBtn addTarget:self action:@selector(DownLoadAPICheckBtnClick) forControlEvents:UIControlEventTouchDown];
        [DownLoadAPIcheckBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.MixAPIcheckBtn.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.view);
            make.width.offset(FFScreenWidth * 0.2);
            make.height.offset(50);
        }];
    }
    return _DownLoadAPIcheckBtn;
}

-(UIImageView *)loadImageView{
    if(_loadImageView == nil){
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.view addSubview:imageView];
        _loadImageView = imageView;
        imageView.backgroundColor = UIColor.redColor;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageviewTapped:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.width.height.offset(FFScreenWidth *0.8);
            make.top.mas_equalTo(self.PickImageBtn.mas_bottom).offset(20);
        }];
    }
    return _loadImageView;
}

-(NSMutableArray *)dataArr{
    if(_dataArr == nil){
        _dataArr =[NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark ----TZImagePicker Delegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [self.dataArr addObjectsFromArray:photos];          //塞进数组
    [self.loadImageView setImage:self.dataArr[0]];
}


@end
