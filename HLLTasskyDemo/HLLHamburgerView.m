//
//  HLLHamburgerView.m
//  HLLTassky
//
//  Created by admin on 15/12/11.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLHamburgerView.h"

@interface HLLHamburgerView ()

@property (nonatomic ,strong) UIImageView * imageView;

@end
@implementation HLLHamburgerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configure];
    }
    return self;
}
// MARK: RotatingView

- (void) rotateWithFractioin:(CGFloat)fractiob{

    CGFloat angle = fractiob * M_PI_2;
    self.imageView.transform = CGAffineTransformMakeRotation(angle);
}

// MARK: Private
- (void) configure{
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu.png"]];
    _imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_imageView];
}

@end
