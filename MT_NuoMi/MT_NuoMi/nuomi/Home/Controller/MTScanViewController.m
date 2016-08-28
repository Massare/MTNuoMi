//
//  MTScanViewController.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/12.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SVProgressHUD.h"

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#define SCAN_WIDTH 255

@interface MTScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation MTScanViewController

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"扫一扫";
    
    if (SIMULATOR == 1)
    {
        NSLog(@"模拟器");
    }else{
        [self openScan];
    }
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MTScreenWidth, MTScreenHeight)];
    [imageview setImage:[UIImage imageNamed:@"qrcode_scan_bg_Green_iphone5"]];
    [self.view addSubview:imageview];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)openScan {
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat topMargin = 128.0;
    //    output.rectOfInterest = CGRectMake(y坐标/父bounds.高, x坐标/父bounds.宽, 高/父bounds.高, 宽/父bounds.宽);
    output.rectOfInterest = CGRectMake(topMargin/MTScreenHeight, (MTScreenWidth-SCAN_WIDTH)/2/MTScreenWidth, SCAN_WIDTH/MTScreenHeight, SCAN_WIDTH/MTScreenWidth);
    
    //初始化链接对象
//    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [self.session startRunning];
}

#pragma mark - **************** AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count>0)
    {
        //停止扫描
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        //NSLog(@"%@",metadataObject.stringValue);
        //        [self dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD showInfoWithStatus:metadataObject.stringValue];
    }
}


@end
