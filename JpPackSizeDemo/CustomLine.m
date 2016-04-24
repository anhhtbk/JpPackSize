//
//  CustomLine.m
//  JpPackSizeDemo
//
//  Created by Hoang Van Trung on 4/24/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "CustomLine.h"

@implementation CustomLine

-(id)initWithStartPoint:(CGPoint) startPoint withEndPoint:(CGPoint) endPoint{
    CGRect cgrect = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:CGRectMake(0, 0, cgrect.size.width, cgrect.size.height-200)];
    _startPoint = startPoint;
    _endPoint = endPoint;
    self.backgroundColor = [UIColor clearColor];
    _color = [UIColor redColor];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
    
    
    return self;
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    if ([self distanceStartPoint:_endPoint endPoint:location] <= 20) {
        _endPoint.y += 20;
        [self setNeedsDisplay];
    }
}

-(double)distanceStartPoint:(CGPoint)p1 endPoint:(CGPoint)p2{
    NSLog(@"%f",hypotf(p1.x - p2.x, p1.y - p2.y));
    NSLog(@"%f,%f",p1.x, p1.y);
    NSLog(@"%f,%f",p2.x, p2.y);
    return hypotf(p1.x - p2.x, p1.y - p2.y);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
 - (void)drawRect:(CGRect)rect {
     [super drawRect:rect];
     
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetStrokeColorWithColor(context, _color.CGColor);
     
     // Draw them with a 2.0 stroke width so they are a bit more visible.
     CGContextSetLineWidth(context, 2.0f);
     
     CGContextMoveToPoint(context, _startPoint.x, _startPoint.y); //start at this point
     
     CGContextAddLineToPoint(context, _endPoint.x, _endPoint.y); //draw to this point
     
     // and now draw the Path!
     CGContextStrokePath(context);
}


@end
