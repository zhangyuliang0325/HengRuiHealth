//
//  CutFamily.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/12.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "CutFamily.h"

@interface CutFamily () {
    
    __weak IBOutlet NSLayoutConstraint *_consHeight;
}

@end

@implementation CutFamily

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, HRHtyScreenHeight, HRHtyScreenWidth, HRHtyScreenHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
}

- (IBAction)actionForCutAccount:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cutAccount:)]) {
        [self.delegate cutAccount:self.family];
    }
    [self hide];
}

- (IBAction)actionForDeleteAccount:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteFamily:)]) {
        [self.delegate deleteFamily:self.family];
    }
    [self hide];
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -(HRHtyScreenHeight));
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)hideDelegate:(BOOL)isHide {
    _consHeight.constant = isHide ? 40 : 81;
}

@end
