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
#import "GUIImageDemoVC.h"

#import "getApiTest.h"
#import "getDynamicApi.h"
#import "YTKBatchRequest.h"
#import "YTKChainRequest.h"
#import "YTKBaseRequest+AnimatingAccessory.h"

@interface HelloWorldVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIVideoEditorControllerDelegate>

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
    self.title = @"😄Hello shit😄";
    NSArray *btnArr = @[@"编辑图片",@"朋友圈demo",@"传输图片demo",@"httpDemo",@"登陆demo",@"socketDemo",@"弹幕demo",@"Crash",@"GPUImage"];
    NSArray *actionArr = @[@"clickSelectAsset",@"clickpushtableVC",@"clickPushImageVC",@"clickHttpApiTestBtn",@"clickloginVcBtn",@"clickSocketTestBtn",@"clickBulletScreenBtn",@"clickCrashVCDemo",@"clickGPUImageDemo"];
    
    int index = 0;
    CGSize size = CGSizeMake(self.view.mj_w/3.0, 65);
    for (NSString * title in btnArr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(index%3*size.width, SafeNavigatorTop + index/3*size.height + 10, size.width, size.height);
        btn.backgroundColor = UIColor.lightGrayColor;
        btn.layer.cornerRadius = 8;
        btn.layer.masksToBounds = YES;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:NSSelectorFromString(actionArr[index]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        index++;
    }
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

-(void)clickpushtableVC{
//    FFTabBarController * vc = [[FFTabBarController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    GUIImageDemoVC * vc = [[GUIImageDemoVC alloc] init];
//    vc.modalPresentationStyle = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickPushImageVC{
    ImageApiTestViewController * vc = [ImageApiTestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickHttpApiTestBtn{
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

-(void)clickloginVcBtn{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickSocketTestBtn{
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

-(void)clickBulletScreenBtn{
    BulletScreenVC *vc = [[BulletScreenVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickCrashVCDemo{
    FFCrashDemoVC * vc = [[FFCrashDemoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickGPUImageDemo{
    GUIImageDemoVC * vc = [[GUIImageDemoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
