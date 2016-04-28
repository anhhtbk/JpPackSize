//
//  CustomLine.h
//  JpPackSizeDemo
//
//  Created by Hoang Van Trung on 4/24/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLine : UIView

@property CGPoint startPoint;
@property CGPoint endPoint1;
@property CGPoint endPoint2;
@property CGPoint endPoint3;
@property CGPoint endPoint4;

@property CGPoint cardPoint1;
@property CGPoint cardPoint2;
@property CGPoint cardPoint3;

@property float angle;
@property float width;
@property UIColor *color1;
@property UIColor *color2;
@property UIColor *color3;

@property (strong, nonatomic) UILabel *lbDistance1;
@property (strong, nonatomic) UILabel *lbDistance2;
@property (strong, nonatomic) UILabel *lbDistance3;

@property float dist1;
@property float dist2;
@property float dist3;

-(id)initWithStartPoint:(CGPoint)startPoint withAngle:(float)angle;
-(void)setEndPoint1:(CGPoint)p1 endPoint2:(CGPoint)p2 endPoint3:(CGPoint)p3;

@end
