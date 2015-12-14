//
//  HLLDetailViewController.h
//  HLLTassky
//
//  Created by admin on 15/12/11.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLHamburgerView.h"

@interface HLLDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *chartView;

@property (nonatomic ,strong) NSString * titleTest;
@property (nonatomic ,strong) HLLHamburgerView * hamburgerView;
@end
