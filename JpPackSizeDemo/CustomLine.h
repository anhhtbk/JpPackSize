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
@property CGPoint endPoint;
@property float width;
@property UIColor *color;

-(id)initWithStartPoint:(CGPoint) startPoint withEndPoint:(CGPoint) endPoint;

@end
