//
//  HLLChartView.h
//  HLLChartDemo
//
//  Created by Youngrocky on 15/12/10.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLLChartViewDelegate <NSObject>


@end

@protocol HLLChartViewDataSource <NSObject>

@required
- (NSInteger) numberWith;

@end
@interface HLLChartView : UIView

@end
