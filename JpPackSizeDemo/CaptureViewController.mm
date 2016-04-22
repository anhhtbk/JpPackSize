//
//  CaptureViewController.m
//  JpPackSize
//
//  Created by VMio69 on 4/22/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "CaptureViewController.h"
#import "opencv2/opencv.hpp"
#import <opencv2/highgui/cap_ios.h>

@interface CaptureViewController () <CvPhotoCameraDelegate>

@property int widthScreen;
@property int heightScreen;
@property (strong, nonatomic) CvPhotoCamera *camera;

@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _widthScreen = [[UIScreen mainScreen] bounds].size.width;
    _heightScreen = [[UIScreen mainScreen] bounds].size.height-64;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _widthScreen, _heightScreen-50)];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:_imageView];
    
    _camera = [[CvPhotoCamera alloc] initWithParentView:_imageView];
    _camera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    _camera.delegate = self;
    _camera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetPhoto;
    _camera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    
    _captureButton = [[UIButton alloc] initWithFrame:CGRectMake((_widthScreen-50)/2, _heightScreen-50, 50, 50)];
    [_captureButton setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [_captureButton setContentMode:UIViewContentModeScaleAspectFit];
    [_captureButton addTarget:self action:@selector(captureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_captureButton];
    
    [_camera start];
    [self.view addSubview:_imageView];
    [_captureButton setEnabled:YES];
    
}

-(void)captureButtonClick{
    [_camera takePicture];
}

- (void) photoCamera:(CvPhotoCamera *) photoCamera capturedImage:(UIImage *) image{
    [_camera stop];
    [_imageView setImage:image];
    [_captureButton setEnabled:NO];
}


- (void) photoCameraCancel:(CvPhotoCamera *) photoCamera{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
