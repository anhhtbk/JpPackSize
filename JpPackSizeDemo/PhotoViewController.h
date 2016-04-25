//
//  PhotoViewController.h
//  JpPackSize
//
//  Created by VMio69 on 4/22/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) NSNumber *sum;
@property (strong, nonatomic) UILabel *labelRight;
@end
