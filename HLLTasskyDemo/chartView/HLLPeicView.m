//
//  HLLPeicView.m
//  HLLChartDemo
//
//  Created by Youngrocky on 15/12/12.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLPeicView.h"
#import "UIColor+HexColor.h"


@implementation NSArray (sum)

- (CGFloat) sum{
    CGFloat sum = 0.0f;
    for (NSInteger index = 0; index < self.count; index ++) {
        sum += [self[index] floatValue];
    }
    return sum;
}
@end

@interface HLLPeic ()
// peic end angle
@property (nonatomic ,assign ,readwrite) CGFloat endAngle;
// peic angle
@property (nonatomic ,assign ,readwrite) CGFloat angle;
// peic ratio
@property (nonatomic ,assign ,readwrite) CGFloat ratio;
@end


IB_DESIGNABLE
@interface HLLPeicView ()
@property (nonatomic ,strong) NSMutableArray * peics;
@end
@implementation HLLPeicView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}
- (void)awakeFromNib{
    [self defaultConfigure];
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}
- (void) defaultConfigure{

    _chartName = @"Group Financial Report";
    _startAngle = 10.0f;
    _step = YES;
    _marginalType = HLLMarginalTypeCircle;
    _marginalPosition = HLLChartMarginalPositionBottom;
    
    
    // temp code
    // #839CB2
    // #3D5476
    // #FEFFFF
    // #6B7D94
    // #CDEBFE
    // #CDD3DB
    // #909CAF
    // #A1C8DF
    // #CF2256
    // #34A6B3
    // #2E5AA3
    // #0BAC45
    // #AC50AA
    // #F0D4D7
    NSArray * colors = @[[UIColor colorWithHexString:@"#977591"],
                         [UIColor colorWithHexString:@"#889F85"],
                         [UIColor colorWithHexString:@"#CDEBFE"],
                         [UIColor colorWithHexString:@"#EF5F8B"]];
    NSArray * datas = @[@10,@30,@40,@20];
    NSArray * marginals = @[@"Fir ",@"Sec ",@"Thr ",@"Four "];
    [self chartViewDatasourceWithColors:colors andDatas:datas];
    
}

- (void) chartViewDatasourceWithColors:(NSArray <UIColor *> *)colors andDatas:(NSArray <NSNumber *> *)datas{

    _peics = [[NSMutableArray alloc] initWithCapacity:colors.count];
    CGFloat startAngle = self.startAngle;
    
    for (NSInteger index = 0; index < colors.count; index ++) {
        
        UIColor * color = colors[index];
        CGFloat data = [datas[index] floatValue];
        
        CGFloat angle = 2 * M_PI * (data / [datas sum]);
        CGFloat endAngle = startAngle + angle;
        
        HLLPeic * peic = [[HLLPeic alloc] init];
        peic.angle = angle;
        peic.endAngle = endAngle;
        peic.ratio = data / [datas sum];
        peic.color = color;
        peic.startnAngle = startAngle;
        if (self.marginal) {
            peic.marginal = self.marginal(index);
        }
        [self.peics addObject:peic];
        startAngle += angle;
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    hll_ClipCorner(rect, 5.0f);
    
    hll_drawLinearGradient_( rect, [UIColor colorWithHexString:@"#909CAF"], [UIColor colorWithHexString:@"##3D5476"]);
    
    CGFloat topBorder = 30.0f;
    CGFloat bottomBorder = 50.0f;
    CGFloat height = CGRectGetHeight(rect);
    CGFloat width = CGRectGetWidth(rect);
    CGFloat peicHeight = CGRectGetHeight(rect) - topBorder - bottomBorder;

    // chart name
    hll_drawText(CGRectMake(40, 10, width - 40, topBorder), self.chartName);
    
    // peic
    CGPoint center = CGPointMake(CGRectGetWidth(rect)/2, (CGRectGetHeight(rect) - bottomBorder - topBorder) / 2+ topBorder);
    CGFloat radius = MIN(peicHeight/2,CGRectGetWidth(rect)/2);

    // marginal
    CGFloat marginalWidth = 50.0f;
    CGFloat marginalHeight = 30.0f;
    
    CGFloat margin_left = 20.0f;
    CGFloat margin = (width - marginalWidth * self.peics.count) / (self.peics.count + 1);
    NSInteger index = 0;
    
    for (HLLPeic * peic in self.peics) {
        
        // 画饼状图
        CGFloat radius_;
        if (self.step) {
            if (peic.ratio <= 0.3) {
                radius_ = radius;
            }
        }
        hll_DrawPeicWithSector(center, radius_, peic);
        
        if (self.marginalPosition != HLLChartMarginalPositionNone) {
            
            // 画图例
            NSString * marginal = peic.marginal;
            UIColor * color = peic.color;
            
            CGRect frame_marginal;
            if (self.marginalPosition == HLLChartMarginalPositionBottom) {
                
                CGRect frame_bottom = CGRectMake(margin*(index+1) + marginalWidth*index, height - bottomBorder, marginalWidth, bottomBorder);
                frame_marginal = frame_bottom;
            }
            if (self.marginalPosition == HLLChartMarginalPositionLeft) {
                
                CGRect frame_left = CGRectMake(margin_left, height - bottomBorder - (self.peics.count - index)* marginalHeight, marginalWidth, marginalHeight);
                frame_marginal = frame_left;
            }
            if (self.marginalPosition == HLLChartMarginalPositionRight) {
                
                CGRect frame_right = CGRectMake(width - margin_left - marginalWidth, height - bottomBorder - (self.peics.count - index)* marginalHeight, marginalWidth, marginalHeight);
                frame_marginal = frame_right;
            }
            
            hll_drawMarginal(frame_marginal, marginal, color ,self.marginalType);
            index += 1;
        }
    }

}

void hll_ClipCorner(CGRect rect,CGFloat radius){
    
    UIBezierPath * be = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [be addClip];
};
void hll_drawLinearGradient_(CGRect rect, UIColor * startColor, UIColor * endColor)
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor.CGColor, (__bridge id) endColor.CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

void hll_drawText(CGRect rect, NSString * text){
    
    [text drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                           NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FEFFFF"]}];
};

void hll_drawMarginal(CGRect rect, NSString * text, UIColor * color ,HLLMarginalType type){
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGSize size = CGSizeMake(5, 5);
    CGFloat height = 20.0f;
    
    //
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect frame = (CGRect){{CGRectGetMinX(rect) - size.width/2, (CGRectGetHeight(rect) - size.height)/2 + CGRectGetMinY(rect) - size.height/2}, size};
    
    if (type == HLLMarginalTypeCircle) {
        CGContextAddArc(context, 2 + CGRectGetMinX(rect),  (CGRectGetHeight(rect) - size.height)/2 + CGRectGetMinY(rect), 2.5, 0, 2 * M_PI, YES);
        CGContextDrawPath(context, kCGPathFill);
    }else{
        CGContextAddRect(context, frame);
        CGContextFillPath(context);
    }
    
    //
    frame = CGRectMake(CGRectGetMaxX(frame) + 5, (CGRectGetHeight(rect) - height)/2 + CGRectGetMinY(rect), 100, height);
    
    [text drawInRect:frame withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                            NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
};
void hll_drawRect2(CGRect rect){
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGContextAddRect(context, rect);
    
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}

void hll_DrawPeicWithSector(CGPoint center,CGFloat radius , HLLPeic * peic){
    
    hll_drawPeic(center, radius, peic.startnAngle, peic.endAngle, peic.color);
    
};
void hll_drawPeic(CGPoint center,CGFloat radius ,CGFloat startAngle ,CGFloat endAngle ,UIColor * color){
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                               radius:radius
                                                           startAngle:startAngle
                                                             endAngle:endAngle
                                                            clockwise:YES];
    [color set];
    [bezierPath addLineToPoint:center];
    [bezierPath fill];
};

@end
@implementation HLLPeic



@end