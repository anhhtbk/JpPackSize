//
//  LineArrow.m
//  JpPackSizeDemo
//
//  Created by VMio69 on 4/25/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "LineArrow.h"
#import "UIBezierPath+dqd_arrowhead/UIBezierPath+dqd_arrowhead.h"

@interface LineArrow()
{
    float minX;
    float maxX;
    float maxY;
}
@end

@implementation LineArrow

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

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *path1 = [UIBezierPath dqd_bezierPathWithArrowFromPoint:_startPoint
                                                              toPoint:_endPoint1
                                                            tailWidth:5.0f
                                                            headWidth:10.0f
                                                           headLength:10.0f];
    
    CAShapeLayer *shape1 = [CAShapeLayer layer];
    shape1.path = path1.CGPath;
    shape1.fillColor = _color1.CGColor;
    [self.layer addSublayer:shape1];
    
    UIBezierPath *path2 = [UIBezierPath dqd_bezierPathWithArrowFromPoint:_startPoint
                                                              toPoint:_endPoint1
                                                            tailWidth:_width
                                                            headWidth:10.0f
                                                           headLength:10.0f];
    
    CAShapeLayer *shape2 = [CAShapeLayer layer];
    shape2.path = path2.CGPath;
    shape2.fillColor = _color2.CGColor;
    [self.layer addSublayer:shape2];
    
    UIBezierPath *path3 = [UIBezierPath dqd_bezierPathWithArrowFromPoint:_startPoint
                                                              toPoint:_endPoint3
                                                            tailWidth:_width
                                                            headWidth:10.0f
                                                           headLength:10.0f];
    
    CAShapeLayer *shape3 = [CAShapeLayer layer];
    shape3.path = path3.CGPath;
    shape3.fillColor = _color3.CGColor;
    [self.layer addSublayer:shape3];
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
