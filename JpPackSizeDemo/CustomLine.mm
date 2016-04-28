//
//  CustomLine.m
//  JpPackSizeDemo
//
//  Created by Hoang Van Trung on 4/24/16.
//  Copyright © 2016 VMio69. All rights reserved.
//

#import "CustomLine.h"
#import "opencv2/opencv.hpp"

using namespace cv;

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
    _endPoint4 = CGPointMake(_startPoint.x - 100, _startPoint.y + 100);
    
    _cardPoint1 = _endPoint2;
    _cardPoint2 = _endPoint3;
    _cardPoint3 = CGPointMake(_startPoint.x, _startPoint.y - 100);
    
    self.backgroundColor = [UIColor clearColor];
    _color1 = [UIColor redColor];
    _color2 = [UIColor greenColor];
    _color3 = [UIColor blueColor];
    

    
    _lbDistance1 = [[UILabel alloc] initWithFrame:CGRectMake(_startPoint.x + 10, (_startPoint.y+_endPoint1.y)/2, 100, 20)];
    _lbDistance1.textColor = _color1;
    _lbDistance1.font = [UIFont systemFontOfSize:14];
    [self addSubview:_lbDistance1];
    
    _lbDistance2 = [[UILabel alloc] initWithFrame:CGRectMake((_startPoint.x+_endPoint2.x)/2-20, (_startPoint.y+_endPoint2.y)/2-30, 100, 20)];
    _lbDistance2.textColor = _color2;
    _lbDistance2.font = [UIFont systemFontOfSize:14];
    [self addSubview:_lbDistance2];
    
    _lbDistance3 = [[UILabel alloc] initWithFrame:CGRectMake((_startPoint.x+_endPoint3.x)/2, (_startPoint.y+_endPoint3.y)/2, 100, 20)];
    _lbDistance3.textColor = _color3;
    _lbDistance3.font = [UIFont systemFontOfSize:14];
    [self addSubview:_lbDistance3];
    
    [self updateDistance];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveCardPoint:)
                                                 name:@"saveClick" object:nil];
    _width = 5;
    return self;
}

-(void)saveCardPoint:(NSNotification *)noti{
    _cardPoint1 = _endPoint2;
    _cardPoint2 = _endPoint3;
}

-(double)distanceStartPoint:(CGPoint)p1 endPoint:(CGPoint)p2{
    double dx = p1.x - p2.x;
    double dy = p1.y - p2.y;
    return sqrt(dx*dx + dy*dy);
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
    
    CGContextRef context4 = UIGraphicsGetCurrentContext();
    CGContextFillRect(context4, CGRectMake(_cardPoint3.x-2, _cardPoint3.y-2, 5, 5));
    CGContextStrokePath(context4);
    
    CGContextRef context5 = UIGraphicsGetCurrentContext();
    CGContextFillRect(context5, CGRectMake(_endPoint4.x-2, _endPoint4.y-2, 5, 5));
    CGContextStrokePath(context5);
    
    
    [self calculate];
    [self updateDistance];
}

-(void)updateDistance{

    //send data to PhotoView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sumDistance" object:nil userInfo:@{@"sumDistance":[NSString stringWithFormat:@"%.0f",_dist1+_dist2+_dist3]}];
    
    // add distance
    [_lbDistance1 setFrame:CGRectMake(_startPoint.x + 10, (_startPoint.y+_endPoint1.y)/2, 100, 20)];
    _lbDistance1.text = [NSString stringWithFormat:@"%.02f cms", _dist1];
    
    [_lbDistance2 setFrame:CGRectMake((_startPoint.x+_endPoint2.x)/2-20, (_startPoint.y+_endPoint2.y)/2-30, 100, 20)];
    _lbDistance2.text = [NSString stringWithFormat:@"%.02f cms", _dist2];
    
    [_lbDistance3 setFrame:CGRectMake((_startPoint.x+_endPoint3.x)/2, (_startPoint.y+_endPoint3.y)/2, 100, 20)];
    _lbDistance3.text = [NSString stringWithFormat:@"%.02f cms", _dist3];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self];
    CGPoint previousLocation = [aTouch previousLocationInView:self];
    
    if ([self distanceStartPoint:_endPoint1 endPoint:previousLocation] <= 20) {
        if (location.y <= _startPoint.y + 30 || location.y >= maxY) {
            return;
        }
        _endPoint1 = CGPointMake(_endPoint1.x, _endPoint1.y + (location.y - previousLocation.y));
        [self setNeedsDisplay];
    }
    
    if ([self distanceStartPoint:_endPoint2 endPoint:previousLocation] <= 20) {
        _endPoint2 = location;
        [self setNeedsDisplay];
    }
    
    if ([self distanceStartPoint:_endPoint3 endPoint:previousLocation] <= 20) {
        _endPoint3 = location;
        [self setNeedsDisplay];
    }
    
    if ([self distanceStartPoint:_cardPoint3 endPoint:location] <= 20) {
        _cardPoint3 = location;
        [self setNeedsDisplay];
    }
    
    if ([self distanceStartPoint:_endPoint4 endPoint:location] <= 20) {
        _endPoint4 = location;
        [self setNeedsDisplay];
    }
}

-(void)calculate{
    Mat input = cvCreateMat(9, 2, CV_32F); //start, end1 2 3 4, card 1 2 3, axb --> 9 points
    Mat X = cvCreateMat(8, 1, CV_32F); // UA=X, image = X, A matrix transformation
    
    input.at<float>(0,0) = _startPoint.x;
    input.at<float>(0,1) = _startPoint.y;
    
    input.at<float>(1,0) = _endPoint1.x;
    input.at<float>(1,1) = _endPoint1.y;
    
    input.at<float>(2,0) = _endPoint2.x;
    input.at<float>(2,1) = _endPoint2.y;
    
    input.at<float>(3,0) = _endPoint3.x;
    input.at<float>(3,1) = _endPoint3.y;
    
    input.at<float>(4,0) = _endPoint4.x;
    input.at<float>(4,1) = _endPoint4.y;
    
    input.at<float>(5,0) = _cardPoint1.x;
    input.at<float>(5,1) = _cardPoint1.y;
    
    input.at<float>(6,0) = _cardPoint2.x;
    input.at<float>(6,1) = _cardPoint2.y;
    
    input.at<float>(7,0) = _cardPoint3.x;
    input.at<float>(7,1) = _cardPoint3.y;
    
    input.at<float>(8,0) = 4.47;
    input.at<float>(8,1) = 2.57;
    
    X.at<float>(0) = 0;
    X.at<float>(1) = input.at<float>(8,1);
    X.at<float>(2) = 0;
    X.at<float>(3) = input.at<float>(8,1);
    X.at<float>(4) = 0;
    X.at<float>(5) = 0;
    X.at<float>(6) = input.at<float>(8,0);
    X.at<float>(7) = input.at<float>(8,0);
    
    Mat U = cvCreateMat(8, 8, CV_32F);
    U = (Mat_<float>(8,8) << input.at<float>(0,0), input.at<float>(0,1), 1, 0, 0, 0, -input.at<float>(0,0) * X.at<float>(0), -input.at<float>(0,1) * X.at<float>(0),
                            input.at<float>(5,0), input.at<float>(5,1), 1, 0, 0, 0, -input.at<float>(5,0) * X.at<float>(1), -input.at<float>(5,1) * X.at<float>(1),
                            input.at<float>(6,0), input.at<float>(6,1), 1, 0, 0, 0, -input.at<float>(7,0) * X.at<float>(2), -input.at<float>(6,1) * X.at<float>(2),
                            input.at<float>(7,0), input.at<float>(7,1), 1, 0, 0, 0, -input.at<float>(7,0) * X.at<float>(3), -input.at<float>(7,1) * X.at<float>(3),
         
                            0, 0, 0, input.at<float>(0,0), input.at<float>(0,1), 1, -input.at<float>(0,0) * X.at<float>(4), -input.at<float>(0,1) * X.at<float>(4),
                            0, 0, 0, input.at<float>(5,0), input.at<float>(5,1), 1, -input.at<float>(5,0) * X.at<float>(5), -input.at<float>(5,1) * X.at<float>(5),
                            0, 0, 0, input.at<float>(6,0), input.at<float>(6,1), 1, -input.at<float>(6,0) * X.at<float>(6), -input.at<float>(6,1) * X.at<float>(6),
                            0, 0, 0, input.at<float>(7,0), input.at<float>(7,1), 1, -input.at<float>(7,0) * X.at<float>(7), -input.at<float>(7,1) * X.at<float>(7)
                            );
    Mat temp = cvCreateMat(8, 1, CV_32F);
    temp = U.inv() * X;
    Mat A = cvCreateMat(3, 3, CV_32F);
    A = (Mat_<float>(3,3) << temp.at<float>(0,0), temp.at<float>(3,0), temp.at<float>(6,0),
                            temp.at<float>(1,0), temp.at<float>(4,0), temp.at<float>(7,0),
                            temp.at<float>(2,0), temp.at<float>(5,0), 1
                            );
    Mat img = cvCreateMat(2, 3, CV_32F);
    img = (Mat_<float>(2,3) << input.at<float>(2,0), input.at<float>(2,1), 1,
                            input.at<float>(3,0), input.at<float>(3,1), 1);
    Mat real = cvCreateMat(2, 3, CV_32F);
    real = img * A;
    _dist2 = real.at<float>(0,0)/real.at<float>(0,2);
    _dist3 = real.at<float>(1,1)/real.at<float>(1,2);
    
    
}



@end
