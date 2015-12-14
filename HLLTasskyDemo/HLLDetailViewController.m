//
//  HLLDetailViewController.m
//  HLLTassky
//
//  Created by admin on 15/12/11.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLDetailViewController.h"
#import "HLLContainerViewController.h"
#import "UIColor+HexColor.h"

@interface HLLDetailViewController ()


@end

@implementation HLLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _hamburgerView = [[HLLHamburgerView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [_hamburgerView addGestureRecognizer:tapGestureRecognizer];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_hamburgerView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#CDEBFE"];
    // Do any additional setup after loading the view.
}
- (void) tap:(UITapGestureRecognizer *)tap{

    UINavigationController * navigation = (UINavigationController *)self.parentViewController;
    HLLContainerViewController * container = (HLLContainerViewController *)navigation.parentViewController;
    [container showMenu:!container.showingMenu animation:YES];
    
//    
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1);
//    
//    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
//    UIImage * screenshot = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 200,200)];
//    imageView.image = screenshot;
//    [self.view addSubview:imageView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
