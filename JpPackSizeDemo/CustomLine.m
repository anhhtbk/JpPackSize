//
//  CustomLine.m
//  JpPackSizeDemo
//
//  Created by Hoang Van Trung on 4/24/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "CustomLine.h"

@interface CustomLine()
{
    float minX;
    float maxX;
    float maxY;
}
@end

@implementation CustomLine

-(id)initWithStartPoint:(CGPoint)startPoint withAngle:(float)angle{
    CGRect cgrect = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:CGRectMake(0, 0, cgrect.size.width, cgrect.size.height-50-64)];
    minX = 10;
    maxX = cgrect.size.width - 10;
    maxY = cgrect.size.height - 134;
    
    _angle = (angle-90)*M_PI_2/90;
    _startPoint = startPoint;
    
    _endPoint1 = CGPointMake(_startPoint.x, _startPoint.y + 100);
    _endPoint2 = CGPointMake(_startPoint.x - 100, _startPoint.y - 100*tan(_angle));
    _endPoint3 = CGPointMake(_startPoint.x + 100, _startPoint.y - 100*tan(_angle));
    
    self.backgroundColor = [UIColor clearColor];
    _color1 = [UIColor redColor];
    _color2 = [UIColor greenColor];
    _color3 = [UIColor blueColor];
    
    _width = 5;
    return self;
}

-(double)distanceStartPoint:(CGPoint)p1 endPoint:(CGPoint)p2{
    double dx = p1.x - p2.x;
    double dy = p1.y - p2.y;
    return dx*dx + dy*dy;
}

-(void)setEndPoint1:(CGPoint)p1 endPoint2:(CGPoint)p2 endPoint3:(CGPoint)p3{
    _endPoint1 = p1;
    _endPoint2 = p2;
    _endPoint3 = p3;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context1, _width); //set width
    
    CGContextSetStrokeColorWithColor(context1, _color1.CGColor);
    CGContextMoveToPoint(context1, _startPoint.x, _startPoint.y); //start at this point
    CGContextAddLineToPoint(context1, _endPoint1.x, _endPoint1.y); //draw to this point
    // and now draw the Path!
    CGContextStrokePath(context1);
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context2, _width); //set width
    
    CGContextSetStrokeColorWithColor(context2, _color2.CGColor);
    CGContextMoveToPoint(context2, _startPoint.x, _startPoint.y); //start at this point
    CGContextAddLineToPoint(context2, _endPoint2.x, _endPoint2.y); //draw to this point
    // and now draw the Path!
    CGContextStrokePath(context2);
    
    CGContextRef context3 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context3, _width); //set width
    
    CGContextSetStrokeColorWithColor(context3, _color3.CGColor);
    CGContextMoveToPoint(context3, _startPoint.x, _startPoint.y); //start at this point
    CGContextAddLineToPoint(context3, _endPoint3.x, _endPoint3.y); //draw to this point
    // and now draw the Path!
    CGContextStrokePath(context3);
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self];
    CGPoint previousLocation = [aTouch previousLocationInView:self];
    
    if ([self distanceStartPoint:_endPoint1 endPoint:previousLocation] <= 400) {
        if (location.y <= _startPoint.y + 30 || location.y >= maxY) {
            return;
        }
        _endPoint1 = CGPointMake(_endPoint1.x, _endPoint1.y + (location.y - previousLocation.y));
        [self setNeedsDisplay];
    }
    
    if ([self distanceStartPoint:_endPoint2 endPoint:previousLocation] <= 400) {
//        if ([self distanceStartPoint:_startPoint endPoint:_endPoint2] <= 400 || location.x <= minX) {
//            return;
//        }
        double deltaX = location.x - previousLocation.x;
        _endPoint2 = CGPointMake(_endPoint2.x + deltaX, _startPoint.y + (_endPoint2.x + deltaX-_startPoint.x)*tan(_angle));
        [self setNeedsDisplay];
    }
    
    if ([self distanceStartPoint:_endPoint3 endPoint:previousLocation] <= 400) {
//        if ([self distanceStartPoint:_startPoint endPoint:_endPoint3] <= 400 || location.x >= maxX) {
//            return;
//        }
        double deltaX = location.x - previousLocation.x;
        _endPoint3 = CGPointMake(_endPoint3.x + deltaX, _startPoint.y - (_endPoint3.x + deltaX-_startPoint.x)*tan(_angle));
        [self setNeedsDisplay];
    }
}

@end
