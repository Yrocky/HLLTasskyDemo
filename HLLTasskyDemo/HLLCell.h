//
//  HLLCell.h
//  HLLTassky
//
//  Created by admin on 15/12/11.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;


- (void) configureCellWithTitle:(NSString *)title;

@end
