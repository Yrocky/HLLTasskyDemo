//
//  HLLLineView.h
//  HLLChartDemo
//
//  Created by Youngrocky on 15/12/12.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , HLLLineType) {

    HLLLineTypeOne  = 1 << 0,
    HLLLineTypeTwo  = 1 << 1
};

@interface HLLPoint : NSObject

@property (nonatomic ,assign) CGFloat data;

@property (nonatomic ,strong ,readonly) NSString * dataText;

@property (nonatomic ,assign ,readonly) CGFloat point;

@end
@interface HLLLineView : UIView

// default 2.0f
@property (nonatomic ,assign) CGFloat lineWidth;

@property (nonatomic ,assign) HLLLineType lineType;
@property (nonatomic ,strong) NSArray * points;
@end
