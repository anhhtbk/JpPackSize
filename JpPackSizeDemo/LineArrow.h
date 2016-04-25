//
//  LineArrow.h
//  JpPackSizeDemo
//
//  Created by VMio69 on 4/25/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineArrow : UIView

@property CGPoint startPoint;
@property CGPoint endPoint1;
@property CGPoint endPoint2;
@property CGPoint endPoint3;
@property float angle;
@property float width;
@property UIColor *color1;
@property UIColor *color2;
@property UIColor *color3;

-(id)initWithStartPoint:(CGPoint)startPoint withAngle:(float)angle;

@end
