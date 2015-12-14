//
//  HLLContainerViewController.m
//  HLLTassky
//
//  Created by admin on 15/12/11.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLContainerViewController.h"
#import "HLLDetailViewController.h"
#import "UIColor+HexColor.h"

#import "HLLLineView.h"
#import "HLLPeicView.h"
#import "HLLChartView.h"
#import "HLLChartViewTwo.h"


@interface HLLContainerViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;
@property (nonatomic ,strong) NSArray * colors;
@property (nonatomic ,strong) NSArray * chartViews;
@end

@implementation HLLContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showingMenu = NO;
    
    HLLLineView * lineView = [[HLLLineView alloc] init];
    HLLPeicView * peicView = [[HLLPeicView alloc] init];
    HLLChartView * chartView = [[HLLChartView alloc] init];
    HLLChartViewTwo * chartViewTwo = [[HLLChartViewTwo alloc] init];
    
    _chartViews = @[lineView,peicView,chartView,chartViewTwo];
    
    _colors = @[[UIColor colorWithHexString:@"#CDEBFE"],
                [UIColor colorWithHexString:@"#839CB2"],
                [UIColor colorWithHexString:@"#A1C8DF"],
                [UIColor colorWithHexString:@"#34A6B3"],
                [UIColor colorWithHexString:@"#AC50AA"],
                [UIColor colorWithHexString:@"#F0D4D7"]];
    // Do any additional setup after loading the view.
}

// 这个写在这里是要将侧边栏隐藏
- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    [self showMenu:_showingMenu animation:NO];
    self.menuContainerView.layer.anchorPoint = CGPointMake(1., 0.5);
}

- (void)menuViewDidSelectedElementWithColor:(UIColor *)color{

    self.detailViewController.view.backgroundColor = color;
//    if (indexPath.row <= 4) {
//        UINavigationController * navigationVC = self.detailViewController.navigationController;
        
//        [navigationVC pushViewController:navigationVC.viewControllers[indexPath.row] animated:YES];
//    }
}

- (CATransform3D) transformForFraction:(CGFloat)fraction{

    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000.0;
    CGFloat angle = (1.0 - fraction) * - M_PI_2;
    CGFloat xOffset = CGRectGetWidth(_menuContainerView.bounds) * 0.5;
    CATransform3D rotateTransform = CATransform3DRotate(identity,angle,0.0,1.0,0.0);
    CATransform3D translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0);
    return CATransform3DConcat(rotateTransform, translateTransform);
}

- (void) showMenu:(BOOL)show animation:(BOOL)animation{

    CGFloat menuOffset = CGRectGetWidth(_menuContainerView.bounds);

    [self.scrollView setContentOffset: show ? CGPointZero : CGPointMake(menuOffset, 0) animated:animation];

    _showingMenu = show;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame));
    
    CGFloat multiplier = 1.0 / CGRectGetWidth(_menuContainerView.bounds);
    CGFloat offset = scrollView.contentOffset.x * multiplier;
    CGFloat fraction = 1.0 - offset;
    _menuContainerView.layer.transform = [self transformForFraction:fraction];
    _menuContainerView.alpha = fraction;
    
    [self.detailViewController.hamburgerView rotateWithFractioin:fraction];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGFloat menuOffset = CGRectGetWidth(_menuContainerView.bounds);
    
    _showingMenu = ! CGPointEqualToPoint(CGPointMake(menuOffset, 0), scrollView.contentOffset);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier  isEqual: @"DetailViewSegue"]) {
        UINavigationController * navigationVC = segue.destinationViewController;
        _detailViewController = (HLLDetailViewController *)navigationVC.topViewController;
    }
}


@end
