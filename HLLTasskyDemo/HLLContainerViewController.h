//
//  HLLContainerViewController.h
//  HLLTassky
//
//  Created by admin on 15/12/11.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLLDetailViewController;

@interface HLLContainerViewController : UIViewController

@property (nonatomic ,strong) HLLDetailViewController * detailViewController;
@property (nonatomic ,assign) BOOL showingMenu;

- (void) menuViewDidSelectedElementWithColor:(UIColor *)color;
- (void) showMenu:(BOOL)show animation:(BOOL)animation;
@end
