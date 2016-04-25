//
//  CaptureViewController.m
//  JpPackSize
//
//  Created by VMio69 on 4/22/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "CaptureViewController.h"
#import "PhotoViewController.h"
#import "opencv2/opencv.hpp"
#import <opencv2/highgui/cap_ios.h>
#import "CustomLine.h"


using namespace cv;

@interface CaptureViewController () <CvPhotoCameraDelegate>

@property int widthScreen;
@property int heightScreen;
@property (strong, nonatomic) CvPhotoCamera *camera;
@property BOOL isCaptured;

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
    
    _isCaptured = NO;
    
    CustomLine *line = [[CustomLine alloc] initWithStartPoint:CGPointMake(_widthScreen/2, _heightScreen/2) withAngle:120];
    
    [self.view addSubview:line];
    
}

-(void)captureButtonClick{
    if (!_isCaptured) {
        [_camera takePicture];
    }else{
        UIAlertController * alert=   [UIAlertController alertControllerWithTitle:@"Done!"
                                                                         message:@"Do you want go to next step?"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes!"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        PhotoViewController *photoView = [PhotoViewController new];
                                        photoView.image = _imageView.image;
                                        
                                        [self.navigationController pushViewController:photoView animated:YES];
                                    }];
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"No, capture again."
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                                   {
                                       _isCaptured = NO;
                                       [_camera start];
                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void) photoCamera:(CvPhotoCamera *) photoCamera capturedImage:(UIImage *) image{
    [_camera stop];
    [_imageView setImage:image];
    _isCaptured = YES;
}


- (void) photoCameraCancel:(CvPhotoCamera *) photoCamera{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [_camera start];
    _isCaptured = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_camera stop];
}

- (void)dealloc
{
    _camera.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
