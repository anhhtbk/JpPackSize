//
//  PhotoViewController.m
//  JpPackSize
//
//  Created by VMio69 on 4/22/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "PhotoViewController.h"
#import "CustomLine.h"

@interface PhotoViewController ()
@property int widthScreen;
@property int heightScreen;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _widthScreen = [[UIScreen mainScreen] bounds].size.width;
    _heightScreen = [[UIScreen mainScreen] bounds].size.height-64;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _widthScreen, _heightScreen-50)];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setImage:_image];
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    _saveButton = [[UIButton alloc] initWithFrame:CGRectMake((_widthScreen-200)/2, _heightScreen-47, 200, 45)];
    
    [_saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_saveButton setTitle:@"Save Photo" forState:UIControlStateNormal];
    [_saveButton setBackgroundColor:[UIColor colorWithRed:100/255. green:150/255. blue:200/255. alpha:1.]];
    [_saveButton.layer setCornerRadius:5];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_saveButton];
    
    CustomLine *line = [[CustomLine alloc] initWithStartPoint:CGPointMake(_widthScreen/2, _heightScreen/2) withAngle:125];
    _sum = [NSNumber numberWithInteger:line.dist1+line.dist2+line.dist3];
    [self.view addSubview:line];

    _labelRight = [[UILabel alloc] initWithFrame:CGRectMake(0,0,_widthScreen,64)] ;
    _labelRight.backgroundColor = [UIColor clearColor];
    _labelRight.font = [UIFont boldSystemFontOfSize:40];
    _labelRight.adjustsFontSizeToFitWidth = NO;
    
    _labelRight.textAlignment = NSTextAlignmentRight;
    
    _labelRight.textColor = [UIColor blackColor];
    _labelRight.text = [NSString stringWithFormat:@"%@ cm", _sum];
    _labelRight.highlightedTextColor = [UIColor blackColor];
    
    // set the view as navigationba title view
    self.navigationItem.titleView = _labelRight;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setSumDistance:)
                                                 name:@"sumDistance" object:nil];
}

-(void)setSumDistance:(NSNotification *)noti{
    _sum = [noti.userInfo valueForKey:@"sumDistance"];
    _labelRight.text = [NSString stringWithFormat:@"%@ cm", _sum];
}

-(void)saveButtonClick{
    //TODO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
