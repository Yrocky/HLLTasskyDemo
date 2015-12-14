//
//  ViewController.m
//  HLLTassky
//
//  Created by admin on 15/12/11.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "ViewController.h"
#import "HLLCell.h"
#import "UIColor+HexColor.h"
#import "HLLContainerViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSMutableArray * titles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray * colors;
@end

@implementation ViewController

- (UIView *)customSnapshotFromView:(UIView *)view{

    // 获得点击cell的快照
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 对快照进行设置
    UIView * snapView = [[UIImageView alloc] initWithImage:image];
    snapView.layer.masksToBounds = NO;
    snapView.layer.cornerRadius = 0.0f;
    snapView.layer.shadowColor = [UIColor blackColor].CGColor;
    snapView.layer.shadowOffset = CGSizeMake(0, 10);
    snapView.layer.shadowRadius = 5.0f;
    snapView.layer.shadowOpacity = 0.4f;
    
    return snapView;
}
- (void) longGesture:(UILongPressGestureRecognizer *)gesture{

    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
    UIGestureRecognizerState state = gesture.state;
    
    static UIView       *snapshot = nil;
    static NSIndexPath  *sourceIndexPath = nil;
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                snapshot = [self customSnapshotFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
//                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    // Fade out.
                    cell.alpha = 0.0;
                } completion:^(BOOL finished) {
                    cell.hidden = YES;
                }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            // 这里将手势的y值付给snapView的center
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [self.titles exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                [self.colors exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo fade out.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
            }];
            break;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    [self.tableView addGestureRecognizer:longGesture];
    
    _titles = [NSMutableArray arrayWithArray:@[@"饼状图",@"柱形图",@"网图",@"波形图",@"直线图",@"图图"]];
    _colors = [NSMutableArray arrayWithArray: @[[UIColor colorWithHexString:@"#CDEBFE"],
                                                [UIColor colorWithHexString:@"#839CB2"],
                                                [UIColor colorWithHexString:@"#A1C8DF"],
                                                [UIColor colorWithHexString:@"#34A6B3"],
                                                [UIColor colorWithHexString:@"#AC50AA"],
                                                [UIColor colorWithHexString:@"#F0D4D7"]]];
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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titles.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HLLCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell configureCellWithTitle:self.titles[indexPath.row]];
    cell.backgroundColor = self.colors[indexPath.row];
    cell.selectedBackgroundView = nil;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",self.titles[indexPath.row]);
    
    HLLContainerViewController * containerVC = (HLLContainerViewController *)self.navigationController.parentViewController;
    [containerVC showMenu:!containerVC.showingMenu animation:YES];
    
    [containerVC menuViewDidSelectedElementWithColor:self.colors[indexPath.row]];
}


@end
