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
#import "BulletScreenVC.h"
#import "FFCrashDemoVC.h"

#import "getApiTest.h"
#import "getDynamicApi.h"
#import "YTKBatchRequest.h"
#import "YTKChainRequest.h"
#import "YTKBaseRequest+AnimatingAccessory.h"

@interface HelloWorldVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIVideoEditorControllerDelegate>

//选择按钮
@property (nonatomic,strong)UIButton *selectAsset;
@property (nonatomic,strong)UIButton *pushTableVCBtn;

@property (nonatomic,strong)UIButton *ImagetestBtn;
@property (nonatomic,strong)UIButton *HttpApiTestBtn;
@property (nonatomic,strong)UIButton *loginVcBtn;
@property (nonatomic,strong)UIButton *SocketTestBtn;
@property (nonatomic,strong)UIButton *bulletScreenBtn;

@property (nonatomic,strong)UIView *oneView;
@property (nonatomic,strong)UIView *twoView;
@property (nonatomic,strong)UIButton *Button1,*Button2;
@property (nonatomic,strong)UIButton *Buuton3,*Button4;


//fuck you

@end

@implementation HelloWorldVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
//    NSLog(@"self:%@",self);
//    HelloWorldVC *vc = [[HelloWorldVC alloc] init];
//    Class class = [HelloWorldVC class];
//    Class superClass = class_getSuperclass(class);
//    Class supersuperClass = class_getSuperclass(superClass);
//    Class metasupersuperClass = class_getSuperclass(object_getClass(superClass));
//
//    NSLog(@"vc:%@",vc);
//    NSLog(@"class:%@",class);
//    NSLog(@"superClass:%@",superClass);
//    NSLog(@"supersuperClass:%@",supersuperClass);
//    NSLog(@"metasupersuperClass:%@",metasupersuperClass);
//
//    Class metaclass = object_getClass(class);
//    Class metametaclass = object_getClass(metaclass);
//    Class rootmetametaclass = object_getClass(metametaclass);
//    NSLog(@"metaclass:%@",metaclass);
//    NSLog(@"metametaclass:%@",metametaclass);
//    NSLog(@"rootmetametaclass:%@",rootmetametaclass);
    
}



-(void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectAsset];
    [self.view addSubview:self.pushTableVCBtn];
    [self.view addSubview:self.ImagetestBtn];
    [self.view addSubview:self.HttpApiTestBtn];
    [self.view addSubview:self.loginVcBtn];
    [self.view addSubview:self.SocketTestBtn];
    [self.view addSubview:self.bulletScreenBtn];    
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
//    FFTabBarController * vc = [[FFTabBarController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    FFCrashDemoVC * vc = [[FFCrashDemoVC alloc] init];
//    vc.modalPresentationStyle = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ClickPushImageVC{
    ImageApiTestViewController * vc = [ImageApiTestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ClickHttpApiTestBtn{
//    [[FFdataEngine sharedInstance] TestDataAPI:self content:@"138" requestBlock:^(id data, int code, NSString *message) {
//        if(code == CorrectCode){
//            NSLog(@"----------成功---------");
//        }
//        else{
//            NSLog(@"----------失败---------");
//        }
//    } errorBlock:^(NSError *error) {
//        NSLog(@"-------请求失败--------");
//    }];
    getApiTest *testApi = [[getApiTest alloc] initWithUserId:@"138"];
    //getDynamicApi *testdynmaicapi = [[getDynamicApi alloc] initWithPage:@"1"];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[testApi]];
    //YTKChainRequest *chainRequest = [[YTKChainRequest alloc] init];
//    [chainRequest addRequest:testApi callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
//        getApiTest *result =(getApiTest*)baseRequest;
//        NSLog(@"result:%@",result);
//    }];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        getApiTest *a = (getApiTest *)requests[0];
        //getDynamicApi *b = (getDynamicApi *)requests[1];
        //,b.responseJSONObject
        NSLog(@"a:%@",a.responseJSONObject);
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        getApiTest *a = (getApiTest *)requests[0];
        //getDynamicApi *b = (getDynamicApi *)requests[1];
        //,b.error
        NSLog(@"a:%@",a.error);
    }];
    
    
//    [testApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        getApiTest *result =(getApiTest*)request;
//
//        NSLog(@"result:%@",[result.responseJSONObject[@"data"] mj_JSONString]);
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"error:%@",request.error);
//    }];
    
}

-(void)ClickloginVcBtn{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ClickSocketTestBtn{
    getApiTest *api = [getApiTest new];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if(request.responseObject){
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if(request.error){
            
        }
    }];
    //SocketTestVc * vc = [SocketTestVc new];
    //[self.navigationController pushViewController:vc animated:YES];
}

-(void)ClickBulletScreenBtn{
    BulletScreenVC *vc = [[BulletScreenVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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

-(UIButton *)bulletScreenBtn{
    if(_bulletScreenBtn==nil){
        _bulletScreenBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,250, 80, 40)];
        _bulletScreenBtn.backgroundColor = [UIColor redColor];
        _bulletScreenBtn.layer.cornerRadius = 10;
        [_bulletScreenBtn setTitle:@"bullet" forState:UIControlStateNormal];
        [self.bulletScreenBtn addTarget:self action:@selector(ClickBulletScreenBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bulletScreenBtn;
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
