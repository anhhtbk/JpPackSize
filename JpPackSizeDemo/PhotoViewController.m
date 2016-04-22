//
//  PhotoViewController.m
//  JpPackSize
//
//  Created by VMio69 on 4/22/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "PhotoViewController.h"

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
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_imageView setImage:_image];
    [self.view addSubview:_imageView];
    
    _saveButton = [[UIButton alloc] initWithFrame:CGRectMake((_widthScreen-200)/2, _heightScreen-47, 200, 45)];
    
    [_saveButton setContentMode:UIViewContentModeScaleAspectFit];
    [_saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_saveButton setTitle:@"Save Photo" forState:UIControlStateNormal];
    [_saveButton setBackgroundColor:[UIColor colorWithRed:100/255. green:150/255. blue:200/255. alpha:1.]];
    [_saveButton.layer setCornerRadius:5];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_saveButton];
    
    _sum = [NSNumber numberWithInteger:100];
    
    UILabel *labelRight = [[UILabel alloc] initWithFrame:CGRectMake(0,0,_widthScreen,64)] ;
    labelRight.backgroundColor = [UIColor clearColor];
    labelRight.font = [UIFont boldSystemFontOfSize:40];
    labelRight.adjustsFontSizeToFitWidth = NO;
    
    labelRight.textAlignment = NSTextAlignmentRight;
    
    labelRight.textColor = [UIColor blackColor];
    labelRight.text = [NSString stringWithFormat:@"%@ cm", _sum];
    labelRight.highlightedTextColor = [UIColor blackColor];
    
    // set the view as navigationba title view
    self.navigationItem.titleView = labelRight;
}

-(void)saveButtonClick{
    //TODO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
