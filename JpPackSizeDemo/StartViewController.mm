//
//  StartViewController.m
//  JpPackSize
//
//  Created by VMio69 on 4/22/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "StartViewController.h"
#import "CaptureViewController.h"

@interface StartViewController ()
@property int widthScreen;
@property int heightScreen;
@end

@implementation StartViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _widthScreen = [[UIScreen mainScreen] bounds].size.width;
    _heightScreen = [[UIScreen mainScreen] bounds].size.height-64;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, _widthScreen-40, _widthScreen-40)];
    _imageView.image = [UIImage imageNamed:@"Box.png"];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:_imageView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, _widthScreen, _widthScreen-20, 2*(_heightScreen-_widthScreen-20)/3)];
    _textView.text = @"Take a photo of box!";
    _textView.selectable = NO;
    _textView.editable = NO;
    _textView.textColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:20];
    _textView.backgroundColor = [UIColor colorWithRed:100/255. green:150/255. blue:200/255. alpha:1.];
    _textView.textAlignment = NSTextAlignmentCenter;
    [_textView.layer setCornerRadius:5];
    
    [self.view addSubview:_textView];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(10, _widthScreen+2*(_heightScreen-_widthScreen-20)/3+10, _widthScreen-20, (_heightScreen-_widthScreen-20)/3)];
    [_button setTitle:@"Capture Photo" forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor colorWithRed:100/255. green:150/255. blue:200/255. alpha:1.]];
    [_button.layer setCornerRadius:5];
    _button.titleLabel.font = [UIFont systemFontOfSize:30];
    [_button addTarget:self action:@selector(capturePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

-(void) capturePhoto{
    CaptureViewController *view = [CaptureViewController new];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
