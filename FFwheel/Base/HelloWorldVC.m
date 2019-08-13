//
//  ViewController.m
//  videoEditTest
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018 apple. All rights reserved.
//
// look my fucking code

#import "HelloWorldVC.h"
#import "FFBlockTest.h"
#import "LoginViewController.h"
#import "FFTabBarController.h"
#import "ImageApiTestViewController.h"

@interface HelloWorldVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIVideoEditorControllerDelegate>

//选择按钮
@property (nonatomic,strong)UIButton *selectAsset;
@property (nonatomic,strong)UIButton *pushTableVCBtn;

@property (nonatomic,strong)UIButton *ImagetestBtn;
@property (nonatomic,strong)UIButton *HttpApiTestBtn;
@property (nonatomic,strong)UIButton *loginVcBtn;
@property (nonatomic,strong)UIButton *SocketTestBtn;

//fuck you

@end

@implementation HelloWorldVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}



-(void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectAsset];
    [self.view addSubview:self.pushTableVCBtn];
    [self.view addSubview:self.ImagetestBtn];
    [self.view addSubview:self.HttpApiTestBtn];
    [self.view addSubview:self.loginVcBtn];
    [self.view addSubview:self.SocketTestBtn];
    self.title = @"😄Hello shit😄";
    //test code 
}

#pragma mark - pickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
        if([mediaType isEqualToString:@"public.movie"]){
            NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            UIVideoEditorController *vc;
            if([UIVideoEditorController canEditVideoAtPath:videoURL.path]){
 
                vc =  [[UIVideoEditorController alloc]init];
                vc.videoPath = videoURL.path;
                vc.delegate =self;
            }
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    }];
}


#pragma mark -action
-(void)clickSelectAsset{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(status == PHAuthorizationStatusDenied){
                NSLog(@"YES");
            }
            else{
                NSLog(@"NO");
            }
        });
    }];
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    vc.delegate = self;
    vc.editing = NO;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)ClickpushtableVC{
    FFTabBarController * vc = [[FFTabBarController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)ClickPushImageVC{
    ImageApiTestViewController * vc = [ImageApiTestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ClickHttpApiTestBtn{
    [[FFdataEngine sharedInstance] TestDataAPI:self content:@"138" requestBlock:^(id data, int code, NSString *message) {
        if(code == CorrectCode){
            NSLog(@"----------成功---------");
        }
        else{
            NSLog(@"----------失败---------");
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"-------请求失败--------");
    }];
}

-(void)ClickloginVcBtn{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ClickSocketTestBtn{
    //SocketTestVc * vc = [SocketTestVc new];
    //[self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -lazy load
-(UIButton *)selectAsset{
    if(_selectAsset==nil){
        //_selectAsset = [[UIButton alloc]initWithFrame:CGRectMake(10 , 74 + SafeAreaBottom,80, 40)];
        _selectAsset = [[UIButton alloc]initWithFrame:CGRectMake(10, 44 + SafeAreaTop,80, 40)];
        _selectAsset.layer.cornerRadius = 10;
        _selectAsset.backgroundColor = [UIColor redColor];
        [_selectAsset setTitle:@"Edit" forState:UIControlStateNormal];
        [self.selectAsset addTarget:self action:@selector(clickSelectAsset) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAsset;
}

-(UIButton *)pushTableVCBtn{
    if(_pushTableVCBtn==nil){
        //_pushTableVCBtn = [[UIButton alloc]initWithFrame:CGRectMake(100 , 74 + SafeAreaBottom, 80, 40)];
        _pushTableVCBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 44  + SafeAreaTop, 80, 40)];
        _pushTableVCBtn.backgroundColor = [UIColor redColor];
        _pushTableVCBtn.layer.cornerRadius = 10;
        [_pushTableVCBtn setTitle:@"table" forState:UIControlStateNormal];
        [self.pushTableVCBtn addTarget:self action:@selector(ClickpushtableVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushTableVCBtn;
}


-(UIButton *)ImagetestBtn{
    if(_ImagetestBtn==nil){
        _ImagetestBtn = [[UIButton alloc]initWithFrame:CGRectMake(190, 44 + SafeAreaTop, 80, 40)];
        _ImagetestBtn.backgroundColor = [UIColor redColor];
        _ImagetestBtn.layer.cornerRadius = 10;
        [_ImagetestBtn setTitle:@"image" forState:UIControlStateNormal];
        [self.ImagetestBtn addTarget:self action:@selector(ClickPushImageVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ImagetestBtn;
}


-(UIButton *)HttpApiTestBtn{
    if(_HttpApiTestBtn==nil){
        _HttpApiTestBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,158, 80, 40)];
        _HttpApiTestBtn.backgroundColor = [UIColor redColor];
        _HttpApiTestBtn.layer.cornerRadius = 10;
        [_HttpApiTestBtn setTitle:@"api" forState:UIControlStateNormal];
        [self.HttpApiTestBtn addTarget:self action:@selector(ClickHttpApiTestBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _HttpApiTestBtn;
}

-(UIButton *)loginVcBtn{
    if(_loginVcBtn==nil){
        _loginVcBtn = [[UIButton alloc]initWithFrame:CGRectMake(100,158, 80, 40)];
        _loginVcBtn.backgroundColor = [UIColor redColor];
        _loginVcBtn.layer.cornerRadius = 10;
        [_loginVcBtn setTitle:@"login" forState:UIControlStateNormal];
        [self.loginVcBtn addTarget:self action:@selector(ClickloginVcBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginVcBtn;
}

-(UIButton *)SocketTestBtn{
    if(_SocketTestBtn==nil){
        _SocketTestBtn = [[UIButton alloc]initWithFrame:CGRectMake(190,158, 80, 40)];
        _SocketTestBtn.backgroundColor = [UIColor redColor];
        _SocketTestBtn.layer.cornerRadius = 10;
        [_SocketTestBtn setTitle:@"socket" forState:UIControlStateNormal];
        [self.SocketTestBtn addTarget:self action:@selector(ClickSocketTestBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SocketTestBtn;
}

//-(UILabel *)BackLabelBtn{
//    if (_BackLabelBtn == nil) {
//        UILabel *Btn = [[UILabel alloc] init];
//        _BackLabelBtn = Btn;
//        Btn.text = @"back";
//        Btn.font = [UIFont systemFontOfSize:14];
//        Btn.backgroundColor = RGBA(255, 255, 255, 0.7);
//        Btn.textAlignment = NSTextAlignmentCenter;
//        Btn.userInteractionEnabled = YES;
//        [Btn sizeToFit];
//        [Btn setFrame:CGRectMake(20, 44+SafeAreaTop,Btn.frame.size.width, 30)];
//        Btn.layer.cornerRadius = 15;
//        Btn.layer.masksToBounds = YES;
//        [[UIApplication sharedApplication].keyWindow addSubview:Btn];
//
//    }
//    return _BackLabelBtn;
//}
//


#pragma mark ---videoEditorControllerDelegate---
//编辑成功的保存path
-(void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath{
    editor.delegate = nil;
    NSLog(@"fffff:%@",editedVideoPath);
}

//编辑失败
-(void)videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error{
    NSLog(@"error:%@",[error description]);
}

//取消编辑
-(void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
