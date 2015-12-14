//
//  HLLChartViewTwo.m
//  HLLChartDemo
//
//  Created by Youngrocky on 15/12/12.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLChartViewTwo.h"
#import "UIColor+HexColor.h"

IB_DESIGNABLE

@interface HLLChartViewTwo ()


@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat max;
@end
@implementation HLLChartViewTwo

CGFloat hll_horizontalScale(CGFloat horizontalStep ,NSArray * datas){

    CGFloat scale = 1.0f;
    NSInteger q = (int)datas.count / horizontalStep;
    
    if(datas.count > 1) {
        scale = (CGFloat)(q * horizontalStep) / (CGFloat)(datas.count - 1);
    }
    return 0;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    
    // 坐标线
    CGFloat axisWidth = 1.5f;
    UIColor * axisColor = [UIColor hll_DarkGray];
    
    CGFloat margin = 15.0f;
    CGFloat chartHeight = height - 2 * margin;
    CGFloat chartWidth = width - 2 * margin;
    
    UIGraphicsPushContext(context);
    CGContextSetLineWidth(context, axisWidth);
    CGContextSetStrokeColorWithColor(context, [axisColor CGColor]);
    
    CGContextMoveToPoint(context, margin, margin);
    CGContextAddLineToPoint(context, margin, chartHeight + margin+ 3);
    CGContextStrokePath(context);

    // 水平方向的竖线
    CGFloat horizontalStep = 10;
    UIColor * horizontalLinerColor = [UIColor hll_LightGray];
    CGFloat horizontalLinerWidth = 1.0f;
    
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:10];
    for(int i=0;i<10;i++) {
        int r = (rand() + rand()) % 1000;
        chartData[i] = [NSNumber numberWithInt:r + 200];
    }
    
    
////    CGFloat scale = hll_horizontalScale(horizontalLinerWidth, chartData);
//    CGFloat minBound = [self minVerticalBound];
//    CGFloat maxBound = [self maxVerticalBound];
    
    for(int i=0;i<horizontalStep;i++) {
        
        CGContextSetStrokeColorWithColor(context,horizontalLinerColor.CGColor);
        CGContextSetLineWidth(context, horizontalLinerWidth);
        
        CGPoint point = CGPointMake((1 + i) * chartWidth / 10 + margin, margin);
        
        // 坐标系线
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, point.x, chartHeight + margin);
        CGContextStrokePath(context);
        
        // 坐标系上的点
        CGContextSetStrokeColorWithColor(context, [axisColor CGColor]);
        CGContextSetLineWidth(context, axisWidth);
        CGContextMoveToPoint(context, point.x - 0.5f, chartHeight + margin);
        CGContextAddLineToPoint(context, point.x - 0.5f, chartHeight + margin + 3);
        CGContextStrokePath(context);
    }
    
    // 垂直方向的横线
    CGFloat verticalStep = 5;
    CGFloat verticalLinerWidth = horizontalLinerWidth;
    UIColor * verticalLinerColor = horizontalLinerColor;
    
    for(int i=0;i<verticalStep + 1;i++) {
//        CGFloat v = maxBound - (maxBound - minBound) / verticalStep * i;
        
        if(1 == 0) {
            CGContextSetLineWidth(context, axisWidth);
            CGContextSetStrokeColorWithColor(context, [axisColor CGColor]);
        } else {
            CGContextSetStrokeColorWithColor(context, [verticalLinerColor CGColor]);
            CGContextSetLineWidth(context, verticalLinerWidth);
        }
        
        CGPoint point = CGPointMake(margin, (i) * chartHeight / verticalStep + margin);
        
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, chartWidth + margin, point.y);
        CGContextStrokePath(context);
    }
}
@end
