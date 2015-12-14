//
//  HLLPeicView.h
//  HLLChartDemo
//
//  Created by Youngrocky on 15/12/12.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLLPeicView,HLLPeic;

typedef NSString *(^valueBlock)(NSInteger item);
typedef UIColor *(^colorBlock)(NSInteger item);

typedef NS_ENUM(NSInteger, HLLChartMarginalPosition) {

    HLLChartMarginalPositionNone        = 1 << 0,
    HLLChartMarginalPositionBottom      = 1 << 1,
    HLLChartMarginalPositionRight       = 1 << 2,
    HLLChartMarginalPositionLeft        = 1 << 3
};
typedef NS_ENUM(NSInteger ,HLLMarginalType) {

    HLLMarginalTypeRectangle = 0,
    HLLMarginalTypeCircle    = 1
};

@protocol HLLPeiceViewDataSource <NSObject>

@required

- (HLLPeic *)peiceView:(HLLPeicView *)chartView peiceForIndex:(NSInteger)index;

@end

@protocol HLLPeiceViewDelegate <NSObject>

- (void) peiceView:(HLLPeicView *)peiceView didSelectedPeicAtIndex:(NSInteger)index;

- (BOOL) peiceView:(HLLPeicView *)peiceView stepAtIndex:(NSInteger)index;

- (HLLChartMarginalPosition) marginalPositionWithPeiceView:(HLLPeicView *)peiceView;

@end
@interface HLLPeic : NSObject

@property (nonatomic ,assign) CGFloat startnAngle;
@property (nonatomic ,strong) UIColor * color;
@property (nonatomic ,strong) NSString * data;
@property (nonatomic ,strong) NSString * marginal;

// peic end angle
@property (nonatomic ,assign ,readonly) CGFloat endAngle;
// peic angle
@property (nonatomic ,assign ,readonly) CGFloat angle;
// peic ratio
@property (nonatomic ,assign ,readonly) CGFloat ratio;
@end


@interface HLLPeicView : UIView

// chart name
@property (nonatomic ,strong) NSString * chartName;
// default NO
@property (nonatomic ,assign) BOOL showChartName;
// default NO
@property (nonatomic ,assign) BOOL showPeicData;
// peic start angle
@property (nonatomic ,assign) CGFloat startAngle;
// default NO
@property (nonatomic ,assign ,getter=isStep) BOOL step;

@property (nonatomic ,assign) HLLChartMarginalPosition marginalPosition;
@property (nonatomic ,assign) HLLMarginalType marginalType;

@property (nonatomic ,assign) valueBlock marginal;

- (void) chartViewDatasourceWithColors:(NSArray <UIColor *> *)colors andDatas:(NSArray <NSNumber *> *)datas;
@end
