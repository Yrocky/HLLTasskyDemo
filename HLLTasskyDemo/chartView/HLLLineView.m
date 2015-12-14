//
//  HLLLineView.m
//  HLLChartDemo
//
//  Created by Youngrocky on 15/12/12.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLLineView.h"

@implementation NSArray (max)

- (CGFloat) maxElement{

    CGFloat max = CGFLOAT_MIN;
    NSAssert(!self||!self.count, @"The Array Must Be Content At Last One Object");
    for (NSInteger index = 0; index < self.count; index ++) {
        if (max < [self[index] floatValue]) {
            max = [self[index] floatValue];
        }
    }
    return max;
}
@end

IB_DESIGNABLE
@implementation HLLLineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}
- (void)awakeFromNib{
    [self defaultConfigure];
}
- (void) defaultConfigure{

    _lineWidth = 2.0f;
    _lineType = HLLLineTypeOne;
    _points = @[@4,@3,@6,@4,@5,@8,@3];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    // 圆角
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    [bezierPath addClip];
    
    // 渐变
    UIColor * startColor = [UIColor colorWithRed:250.0/255.0 green:233.0/255.0 blue:222.0/255.0 alpha:1];
    UIColor * endColor = [UIColor colorWithRed:252.0/255.0 green:79.0/255.0 blue:8.0/255.0 alpha:1];
    hll_drawLinearGradient(rect, startColor,endColor);

    
    // 划线
//    NSArray * garphPoints = @[@4,@3,@6,@4,@5,@8,@3];

    CGFloat margin = 20.0f;
    CGFloat space = (width - margin * 2) / (self.points.count - 1);
    CGFloat topBorder = 60.0f;
    CGFloat bottomBorder = 50.0f;
    CGFloat graphHeight = height - topBorder - bottomBorder;
    CGFloat maxValue = 8;
    
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    
    UIBezierPath * graphPath = [[UIBezierPath alloc] init];
    graphPath.lineWidth = self.lineWidth;
    [graphPath stroke];
    
    for (NSInteger index = 0; index < self.points.count; index ++) {
        
        CGFloat columnXPoint;
        columnXPoint = index * space + margin;
        
        CGFloat columnYPoint;
        columnYPoint = graphHeight * ([self.points[index]floatValue] / maxValue);
        columnYPoint = graphHeight + topBorder - columnYPoint;
        if (!index) {
            [graphPath moveToPoint:CGPointMake(columnXPoint, columnYPoint)];
        }else{
        
            [graphPath addLineToPoint:CGPointMake(columnXPoint, columnYPoint)];
        }
    }
    [graphPath stroke];

    // 渐变
    CGContextSaveGState(context);
    UIBezierPath * clippingPath = [graphPath copy];
    [clippingPath addLineToPoint:CGPointMake(width - margin, height)];
    [clippingPath addLineToPoint:CGPointMake(margin, height)];
    [clippingPath closePath];
    
    [clippingPath addClip];

    CGFloat highestYPoint = topBorder;
    
    CGPoint startPoint = CGPointMake(margin, highestYPoint);
    CGPoint endPoint = CGPointMake(margin, height);
    
    hll_drawLinearGradientWithColor(startPoint,endPoint,[UIColor colorWithWhite:1 alpha:0.5],[UIColor colorWithWhite:1 alpha:0]);
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);

    CGContextRestoreGState(context);
    
    // 画点
    
    for (NSInteger index = 0; index < self.points.count; index ++) {
        
        CGFloat columnXPoint;
        columnXPoint = index * space + margin;
        
        CGFloat columnYPoint;
        columnYPoint = graphHeight * ([self.points[index]floatValue] / maxValue);
        columnYPoint = graphHeight + topBorder - columnYPoint;
        
        CGPoint point = CGPointMake(columnXPoint - 4, columnYPoint - 4);
        UIBezierPath * bezier = [UIBezierPath bezierPathWithOvalInRect:(CGRect){point,{6, 6}}];
        [bezier fill];
    }
}

void hll_drawLinearGradient( CGRect rect, UIColor * startColor, UIColor * endColor)
{
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    hll_drawLinearGradientWithColor(startPoint, endPoint, startColor, endColor);
}

void hll_drawLinearGradientWithGradient(CGGradientRef gradient,CGPoint startPoint,CGPoint endPoint){
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
};

void hll_drawLinearGradientWithColor(CGPoint startPoint,CGPoint endPoint,UIColor * startColor, UIColor * endColor){
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor.CGColor, (__bridge id) endColor.CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGContextSaveGState(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
};


@end
