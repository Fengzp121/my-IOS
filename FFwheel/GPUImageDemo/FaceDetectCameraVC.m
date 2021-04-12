//
//  FaceDetectCameraVC.m
//  FFwheel
//
//  Created by 你吗 on 2021/4/9.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "FaceDetectCameraVC.h"
#import <GPUImage/GPUImage.h>
#import "FFFaceDetect.h"
#import "FaceDetectPointFilter.h"

@interface FaceDetectCameraVC ()<GPUImageVideoCameraDelegate>
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, strong) UIButton *controlBtn;
@property (nonatomic, strong) UIButton *typeBtn;
@end

@implementation FaceDetectCameraVC
{
    FaceDetectPointFilter *faceFilter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //授权face
    [[FFFaceDetect defaultInstance] licenseFacepp];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.delegate = self;
    //self.videoCamera.horizontallyMirrorRearFacingCamera = YES;
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.filterView.center = self.view.center;
    
    [self.view addSubview:self.filterView];
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
    
    faceFilter = [[FaceDetectPointFilter alloc] init];
    [self.videoCamera addTarget:faceFilter];
    [faceFilter addTarget:self.filterView];
    
    self.controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.controlBtn.backgroundColor = UIColor.whiteColor;
    [self.controlBtn setTitle:@"开启" forState:UIControlStateNormal];
    [self.controlBtn setTitle:@"关闭" forState:UIControlStateSelected];
    [self.controlBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.controlBtn addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.controlBtn];
    self.controlBtn.selected = NO;  //默认关闭
    [self.controlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.width.offset(100);
        make.height.offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.typeBtn.backgroundColor = UIColor.whiteColor;
    [self.typeBtn setTitle:@"选择类型" forState:UIControlStateNormal];
    [self.typeBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.typeBtn addTarget:self action:@selector(selectDetectType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.width.offset(100);
        make.height.offset(50);
        make.left.equalTo(self.controlBtn.mas_right).offset(20);
    }];
}


- (void)switchButtonAction:(UIButton *)sender{
    if(sender.selected){
        sender.selected = NO;
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:self.filterView];
        [[FFFaceDetect defaultInstance] stop];
    }else{
        sender.selected = YES;
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:faceFilter];
        [faceFilter addTarget:self.filterView];
        [[FFFaceDetect defaultInstance] start];
    }
}

- (void)selectDetectType:(UIButton *)sender{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择检测算法" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"Face++" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_FACEPP;
    }];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"OpenCV+Stasm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_OPENCV;
    }];
    UIAlertAction *actionThree = [UIAlertAction actionWithTitle:@"Vision" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FFFaceDetect defaultInstance].faceDetectType = FFFaceDetectType_VISION;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消选择" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:actionOne];
    [alertVC addAction:actionTwo];
    [alertVC addAction:actionThree];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Camera Delegate
-(void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    int facePointCount = 0;
    float * facePoint = [[FFFaceDetect defaultInstance] detectWithSampleBuffer:sampleBuffer facePointCount:&facePointCount isMirror:YES];
    faceFilter.facesPoints = facePoint;
    for (int i = 0; i < facePointCount; i++) {
        printf("facePoint:%f ",facePoint[i]);
    }
    faceFilter.facesPointCount = facePointCount;
    NSLog(@"facePoint:%i",facePointCount);
}

@end

//facepp ponit x:638.270691 y:672.838867 facepp ponit x:674.977478 y:678.093750 facepp ponit x:712.517456 y:681.104858 facepp ponit x:750.664429 y:681.683655 facepp ponit x:789.192261 y:679.641663 facepp ponit x:827.874878 y:674.790527 facepp ponit x:866.486084 y:666.941711 facepp ponit x:905.499634 y:658.250305 facepp ponit x:943.437195 y:646.260986 facepp ponit x:979.984680 y:630.907837 facepp ponit x:1014.827881 y:612.124939 facepp ponit x:1047.652710 y:589.846558 facepp ponit x:1078.203735 y:565.202148 facepp ponit x:1106.905151 y:537.483215 facepp ponit x:1130.380859 y:505.272491 facepp ponit x:1145.254395 y:467.152588 facepp ponit x:1148.149536 y:421.706177 facepp ponit x:1141.437256 y:375.204376 facepp ponit x:1123.890747 y:336.045227 facepp ponit x:1098.561646 y:302.929779 facepp ponit x:1068.501831 y:274.559113 facepp ponit x:1036.762817 y:249.634338 facepp ponit x:1002.528198 y:227.550232 facepp ponit x:966.008972 y:209.967239 facepp ponit x:927.711060 y:196.701340 facepp ponit x:888.140442 y:187.568451 facepp ponit x:847.803223 y:182.384521 facepp ponit x:807.507141 y:178.692383 facepp ponit x:767.549011 y:177.811829 facepp ponit x:728.082825 y:179.554581 facepp ponit x:689.262390 y:183.732361 facepp ponit x:651.241577 y:190.156860 facepp ponit x:614.174255 y:198.639801 facepp ponit x:617.447144 y:673.212280 facepp ponit x:573.253174 y:648.906982 facepp ponit x:555.707581 y:601.700806 facepp ponit x:559.472290 y:547.764526 facepp ponit x:577.049438 y:502.497070 facepp ponit x:572.938477 y:401.675812 facepp ponit x:551.067627 y:356.801270 facepp ponit x:542.741638 y:301.614075 facepp ponit x:555.112000 y:250.196655 facepp ponit x:596.440308 y:216.992676 facepp ponit x:644.533081 y:447.635315 facepp ponit x:690.913696 y:446.079254 facepp ponit x:737.294373 y:444.523163 facepp ponit x:783.674988 y:442.967102 facepp ponit x:831.939514 y:495.192932 facepp ponit x:839.612366 y:477.238831 facepp ponit x:841.536133 y:439.057495 facepp ponit x:836.388000 y:399.640533 facepp ponit x:825.624939 y:381.355255 facepp ponit x:669.768616 y:615.991455 facepp ponit x:655.779419 y:594.064392 facepp ponit x:653.860229 y:538.883545 facepp ponit x:670.199463 y:516.392334 facepp ponit x:676.749634 y:540.722717 facepp ponit x:678.132202 y:593.465210 facepp ponit x:659.246826 y:363.285950 facepp ponit x:642.685547 y:341.188812 facepp ponit x:639.497986 y:285.456543 facepp ponit x:649.033630 y:260.800354 facepp ponit x:659.399841 y:283.759705 facepp ponit x:662.449951 y:337.454163 facepp ponit x:601.814087 y:638.022156 facepp ponit x:593.321655 y:597.220215 facepp ponit x:593.297852 y:551.439148 facepp ponit x:604.109863 y:505.436768 facepp ponit x:600.156982 y:396.024445 facepp ponit x:585.090820 y:349.737061 facepp ponit x:580.799438 y:301.914124 facepp ponit x:585.191528 y:257.621460 facepp ponit x:649.962524 y:567.282349 facepp ponit x:681.087280 y:567.275269 facepp ponit x:663.291626 y:561.962280 facepp ponit x:637.003479 y:313.161804 facepp ponit x:664.351746 y:310.289490 facepp ponit x:648.492432 y:313.635254 facepp ponit x:669.983459 y:492.706940 facepp ponit x:665.371643 y:399.436035 facepp ponit x:769.706604 y:511.604279 facepp ponit x:762.346130 y:370.041199 facepp ponit x:818.517456 y:528.828125 facepp ponit x:809.247070 y:347.631104 facepp ponit x:961.309692 y:530.018555 facepp ponit x:935.040588 y:499.006317 facepp ponit x:916.328125 y:459.804382 facepp ponit x:921.158752 y:432.213043 facepp ponit x:912.983154 y:405.095612 facepp ponit x:926.659180 y:360.184174 facepp ponit x:949.146851 y:318.989319 facepp ponit x:975.495361 y:346.671326 facepp ponit x:995.732300 y:381.205994 facepp ponit x:1005.072388 y:426.214783 facepp ponit x:1000.765747 y:469.846497 facepp ponit x:984.204712 y:503.278015 facepp ponit x:960.540771 y:514.895752 facepp ponit x:953.051147 y:480.096436 facepp ponit x:950.811157 y:429.606964 facepp ponit x:946.462036 y:375.770386 facepp ponit x:950.202332 y:335.520905 facepp ponit x:955.199097 y:374.841339 facepp ponit x:961.555664 y:428.792847 facepp ponit x:961.320801 y:479.917358 facepp ponit x:663.291626 y:561.962280 facepp ponit x:648.492432 y:313.635254

//facePoint:-0.739077facePoint:-0.075961facePoint:-0.743361facePoint:-0.027685facePoint:-0.749613facePoint:0.021399facePoint:-0.754327facePoint:0.071099facePoint:-0.753998facePoint:0.121225facePoint:-0.745122facePoint:0.171586facePoint:-0.724193facePoint:0.221991facePoint:-0.700927facePoint:0.272029facePoint:-0.673844facePoint:0.321713facePoint:-0.642097facePoint:0.370673facePoint:-0.604845facePoint:0.418537facePoint:-0.561243facePoint:0.464933facePoint:-0.511569facePoint:0.508276facePoint:-0.456735facePoint:0.550553facePoint:-0.390905facePoint:0.586655facePoint:-0.308245facePoint:0.611470facePoint:-0.202920facePoint:0.619891facePoint:-0.077657facePoint:0.613382facePoint:0.037101facePoint:0.593512facePoint:0.141698facePoint:0.563378facePoint:0.236476facePoint:0.526075facePoint:0.321780facePoint:0.484700facePoint:0.398151facePoint:0.437964facePoint:0.458964facePoint:0.385407facePoint:0.504634facePoint:0.328271facePoint:0.535574facePoint:0.267801facePoint:0.552198facePoint:0.205240facePoint:0.561070facePoint:0.142479facePoint:0.563018facePoint:0.080514facePoint:0.558216facePoint:0.019297facePoint:0.546838facePoint:-0.041217facePoint:0.529058facePoint:-0.101075facePoint:0.505050facePoint:-0.160321facePoint:-0.746189facePoint:-0.123199facePoint:-0.704620facePoint:-0.176310facePoint:-0.616003facePoint:-0.198215facePoint:-0.508134facePoint:-0.197249facePoint:-0.416033facePoint:-0.179652facePoint:-0.187750facePoint:-0.204270facePoint:-0.066107facePoint:-0.240175facePoint:0.085000facePoint:-0.257215facePoint:0.234872facePoint:-0.245069facePoint:0.350427facePoint:-0.188917facePoint:-0.291533facePoint:-0.097527facePoint:-0.307406facePoint:-0.035112facePoint:-0.323279facePoint:0.027304facePoint:-0.339152facePoint:0.089719facePoint:-0.414674facePoint:0.167159facePoint:-0.375665facePoint:0.176491facePoint:-0.291619facePoint:0.179249facePoint:-0.189748facePoint:0.169965facePoint:-0.140462facePoint:0.154182facePoint:-0.657043facePoint:-0.0301282021-04-12 09:51:57.639808+0800 FFwheel[29950:5611203] facePoint:106
//
//
//facePoint:-0.812081facePoint:0.120301facePoint:-0.825503facePoint:0.240602facePoint:-0.812081facePoint:0.360902facePoint:-0.785235facePoint:0.503759facePoint:-0.624161facePoint:0.661654facePoint:-0.355705facePoint:0.751880facePoint:-0.140940facePoint:0.774436facePoint:0.100671facePoint:0.751880facePoint:0.422819facePoint:0.654135facePoint:0.583893facePoint:0.488722facePoint:0.597315facePoint:0.353383facePoint:0.597315facePoint:0.225564facePoint:0.557047facePoint:0.097744facePoint:0.127517facePoint:-0.248120facePoint:-0.181208facePoint:-0.278196facePoint:-0.476510facePoint:-0.233083facePoint:-0.476510facePoint:-0.007519facePoint:-0.597315facePoint:-0.007519facePoint:-0.691275facePoint:0.037594facePoint:-0.583893facePoint:0.030075facePoint:-0.476510facePoint:0.030075facePoint:-0.355705facePoint:0.022556facePoint:-0.033557facePoint:0.015038facePoint:0.100671facePoint:-0.022556facePoint:0.234899facePoint:-0.015038facePoint:0.342282facePoint:0.030075facePoint:0.221477facePoint:0.022556facePoint:0.100671facePoint:0.022556facePoint:0.114094facePoint:0.060150facePoint:-0.489933facePoint:0.067669facePoint:-0.382550facePoint:0.120301facePoint:-0.436242facePoint:0.090226facePoint:-0.489933facePoint:0.082707facePoint:-0.543624facePoint:0.090226facePoint:-0.597315facePoint:0.120301facePoint:-0.543624facePoint:0.127820facePoint:-0.489933facePoint:0.135338facePoint:-0.436242facePoint:0.127820facePoint:-0.4899332021-04-12 09:52:58.626047+0800 FFwheel[29950:5611664] facePoint:77

//facePoint:1.000411facePoint:-0.999447facePoint:0.999830facePoint:-0.999449facePoint:1.000242facePoint:-0.999423facePoint:1.000006facePoint:-0.999435facePoint:1.000256facePoint:-0.999513facePoint:0.999996facePoint:-0.999510facePoint:1.000168facePoint:-0.999483facePoint:0.998417facePoint:-0.999481facePoint:0.999033facePoint:-0.999465facePoint:0.998596facePoint:-0.999452facePoint:0.998848facePoint:-0.999457facePoint:0.998596facePoint:-0.999543facePoint:0.998869facePoint:-0.999534facePoint:0.998720facePoint:-0.999513facePoint:1.000670facePoint:-0.999549facePoint:1.000239facePoint:-0.999635facePoint:0.999773facePoint:-0.999617facePoint:0.999768facePoint:-0.999718facePoint:1.000267facePoint:-0.999740facePoint:1.000695facePoint:-0.999603facePoint:0.998110facePoint:-0.999569facePoint:0.998619facePoint:-0.999657facePoint:0.999145facePoint:-0.999627facePoint:0.999162facePoint:-0.999736facePoint:0.998596facePoint:-0.999767facePoint:0.998087facePoint:-0.999625facePoint:0.999995facePoint:-0.998682facePoint:0.999895facePoint:-0.998754facePoint:0.999758facePoint:-0.998813facePoint:0.999605facePoint:-0.998852facePoint:0.999450facePoint:-0.998836facePoint:0.999296facePoint:-0.998856facePoint:0.999122facePoint:-0.998823facePoint:0.998956facePoint:-0.998772facePoint:0.998817facePoint:-0.998707facePoint:0.998991facePoint:-0.998629facePoint:0.999206facePoint:-0.998578facePoint:0.999430facePoint:-0.9985612021-04-12 10:11:16.694600+0800 FFwheel[30025:5619928] facePoint:76

//facePoint:552.743652 facePoint:336.929962 facePoint:541.523376 facePoint:464.632843 facePoint:553.188904 facePoint:377.153564 facePoint:547.400696 facePoint:428.347229 facePoint:537.249023 facePoint:358.448181 facePoint:533.954163 facePoint:420.752563 facePoint:542.057678 facePoint:379.403839 facePoint:518.370483 facePoint:779.108276 facePoint:527.364502 facePoint:631.434204 facePoint:524.247742 facePoint:737.478210 facePoint:526.563049 facePoint:676.720886 facePoint:508.664062 facePoint:731.852600 facePoint:512.582275 facePoint:663.500549 facePoint:516.055176 facePoint:695.848206 facePoint:531.460815 facePoint:274.625580 facePoint:509.020264 facePoint:350.290955 facePoint:499.580994 facePoint:448.037109 facePoint:483.641113 facePoint:437.348328 facePoint:493.792755 facePoint:330.882355 facePoint:523.357239 facePoint:262.811646 facePoint:495.306610 facePoint:846.053772 facePoint:481.503906 facePoint:721.163757 facePoint:487.826447 facePoint:592.054443 facePoint:470.817963 facePoint:583.897217 facePoint:464.851624 facePoint:725.101746 facePoint:486.579742 facePoint:852.242065 facePoint:695.757446 facePoint:436.504456 facePoint:679.194214 facePoint:439.317291 facePoint:663.165283 facePoint:462.101288 facePoint:651.766907 facePoint:500.918457 facePoint:651.766907 facePoint:543.111023 facePoint:646.602051 facePoint:582.209534 facePoint:651.232605 facePoint:636.497314 facePoint:661.384277 facePoint:687.409668 facePoint:675.097961 facePoint:727.352051 facePoint:689.345886 facePoint:685.721985 facePoint:700.744263 facePoint:631.152893 facePoint:707.868225 facePoint:569.833008 2021-04-12 10:25:25.427463+0800 FFwheel[30066:5626205] facePoint:76

//facePoint:-0.276935 facePoint:-0.525009 facePoint:0.104885 facePoint:-0.530338 facePoint:-0.165056 facePoint:-0.518870 facePoint:-0.008295 facePoint:-0.523851 facePoint:-0.181317 facePoint:-0.540647 facePoint:-0.008946 facePoint:-0.542616 facePoint:-0.108466 facePoint:-0.534276 facePoint:1.010974 facePoint:-0.559412 facePoint:0.615495 facePoint:-0.544469 facePoint:0.906900 facePoint:-0.547597 facePoint:0.740383 facePoint:-0.544238 facePoint:0.884785 facePoint:-0.569721 facePoint:0.707860 facePoint:-0.562887 facePoint:0.813234 facePoint:-0.559991 facePoint:-0.463942 facePoint:-0.547828 facePoint:-0.196928 facePoint:-0.566362 facePoint:0.093176 facePoint:-0.567172 facePoint:0.086672 facePoint:-0.586748 facePoint:-0.222947 facePoint:-0.587559 facePoint:-0.484757 facePoint:-0.559064 facePoint:1.180093 facePoint:-0.590686 facePoint:0.857466 facePoint:-0.595957 facePoint:0.545245 facePoint:-0.580261 facePoint:0.516625 facePoint:-0.600706 facePoint:0.849660 facePoint:-0.618139 facePoint:1.183996 facePoint:-0.602733 facePoint:0.166028 facePoint:-0.348249 facePoint:0.214812 facePoint:-0.362612 facePoint:0.284411 facePoint:-0.375354 facePoint:0.367670 facePoint:-0.384389 facePoint:0.461986 facePoint:-0.382536 facePoint:0.551750 facePoint:-0.388327 facePoint:0.657124 facePoint:-0.383462 facePoint:0.758596 facePoint:-0.374659 facePoint:0.845757 facePoint:-0.363771 facePoint:0.755994 facePoint:-0.346859 facePoint:0.637610 facePoint:-0.334581 facePoint:0.507519 facePoint:-0.328789 2021-04-12 10:35:31.251657+0800 FFwheel[30079:5630079] facePoint:76
