//
//  HLLChartView.m
//  HLLChartDemo
//
//  Created by Youngrocky on 15/12/10.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLChartView.h"

IB_DESIGNABLE

@interface HLLChartView ()

@end
@implementation HLLChartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat margin_x = 40.0f;
    CGFloat margin_x_cutline = 20.0f;
    CGFloat margin_y = 10.0f;
    CGFloat height_cutline = 30.0f;
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    CGContextSaveGState(context);

    // 表头
    NSString * chartName = @"应收各款项类型报表";
    CGRect chartNameFrame = CGRectMake(margin_x, margin_y, CGRectGetWidth(rect) - margin_y, 22.0f);
    hll_drawRect(context, chartNameFrame);
    [chartName drawInRect:chartNameFrame withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                         NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    // 图例
    CGRect cutlineFrame = CGRectMake(margin_x_cutline, CGRectGetHeight(rect) - height_cutline - margin_y, CGRectGetWidth(rect) - 2 * margin_x_cutline, height_cutline);
    
    hll_drawRect(context, cutlineFrame);
    
    // col标示
    CGFloat height_col = 40.0f;
    CGRect colFrame = CGRectMake(margin_x, CGRectGetMinY(cutlineFrame) - height_col, CGRectGetWidth(rect) - 2 * margin_x, height_col);
    
    hll_drawRect(context, colFrame);

    
    CGFloat height_data = CGRectGetMinY(colFrame) - CGRectGetMaxY(chartNameFrame);
    hll_drawRect(context, CGRectMake(10, CGRectGetMaxY(chartNameFrame), 25, height_data));
    // 分割线
    NSArray * rows = @[@650,@500,@450,@300,@150,@0];
    for (NSInteger index = 0; index < rows.count; index ++) {
        
        CGFloat height = height_data/rows.count;
        CGFloat y = (index + 1) * height + CGRectGetMaxY(chartNameFrame);
        CGFloat min_x = margin_x;
        CGFloat max_x = CGRectGetMaxX(cutlineFrame);
        hll_drawLineWithContext(context, min_x, max_x, y);
        
        // 画row值
        NSString * text = [NSString stringWithFormat:@"%@",rows[index]];
        CGRect rowRect = CGRectMake(0, y - height/2, margin_x - 5, height);
        hll_drawLabelInContext(context, text, rowRect);
    }
    
    hll_drawRect(context, CGRectMake(margin_x, CGRectGetMaxY(chartNameFrame), CGRectGetMaxX(cutlineFrame) - margin_x, height_data));
    
    //
    NSArray * times = @[@"一次性",@"商货",@"公积金"];
    NSArray * datas = @[@800,@300,@450];
    NSArray * colorss = @[[UIColor orangeColor],
                          [UIColor greenColor],
                          [UIColor purpleColor]];
    CGFloat dataWidth = 20.0f;
    CGFloat margin = (CGRectGetMaxX(cutlineFrame) - margin_x - times.count * dataWidth) / (times.count + 1);
    CGFloat max_value = [rows[0] floatValue];
    CGFloat height_temp = height_data * (1-1/(rows.count + 1));
    for (NSInteger index = 0; index < times.count; index ++) {
        
        CGFloat x = margin * (index + 1) + dataWidth * index + margin_x;
        CGFloat yyy = height_data * ([datas[index] floatValue]/800);
        
        CGFloat height = height_data;
        CGFloat y = height_data - yyy + CGRectGetMaxY(chartNameFrame);
        
        hll_drawRectWithContext(context, CGRectMake(x, y, dataWidth, height), dataWidth, colorss[index]);
    }
    
    CGContextRestoreGState(context);
}

void hll_drawRect(CGContextRef context,CGRect rect){

    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGContextAddRect(context, rect);
    
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}
void hll_drawRectWithContext(CGContextRef context, CGRect rect,CGFloat width,UIColor * color){

    CGContextSetLineWidth(context, width);
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    CGContextAddRect(context, rect);
    
    CGContextStrokePath(context);
    CGContextSaveGState(context);
    
};
void hll_drawLineWithContext(CGContextRef context, CGFloat min_x,CGFloat max_x,CGFloat y){
    
    CGPoint lines[] = {
        CGPointMake(min_x, y),
        CGPointMake(max_x, y),
    };
    CGContextAddLines(context, lines, sizeof(lines)/sizeof(lines[0]));
    CGContextSetLineWidth(context, 0.5);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGContextStrokePath(context);
};

void hll_drawLabelInContext(CGContextRef context,NSString * text,CGRect rect){

    UILabel * rowLabel = [[UILabel alloc] initWithFrame:rect];
    rowLabel.textAlignment = NSTextAlignmentRight;
    rowLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],
                                                                                          NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [rowLabel drawTextInRect:rect];
};
@end
