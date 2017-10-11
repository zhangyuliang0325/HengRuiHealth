//
//  HomeExpertListHeader.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HomeExpertListHeader.h"

@interface HomeExpertListHeader () {
    
    __weak IBOutlet UIButton *_btnPrice;
    __weak IBOutlet UIButton *_btnAptitude;
    __weak IBOutlet NSLayoutConstraint *_consSlideCenter;
    __weak IBOutlet UIButton *_btnEvalue;
    NSArray *_btns;
}

@end

@implementation HomeExpertListHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    _consSlideCenter.constant = - HRHtyScreenWidth / 3;
    self.type = reviewExpert;
    _btns = @[_btnEvalue, _btnPrice, _btnAptitude];
}

#pragma mark - Action


- (IBAction)actionForReviewButton:(UIButton *)sender {
    [self responseButtonActionForType:reviewExpert];
//    [self selectButton:sender];
}

- (IBAction)actionForAptitudeButton:(UIButton *)sender {
    [self responseButtonActionForType:aptitudeExpert];
//    [self selectButton:sender];
}

- (IBAction)actionForPriceButton:(UIButton *)sender {
    [self responseButtonActionForType:priceExpert];
//    [self selectButton:sender];
}

#pragma mark - Setter 

- (void)setType:(ExpertType)type {
    _type = type;
    CGFloat consContent = (type - 1) * HRHtyScreenWidth / 3;
    _consSlideCenter.constant = consContent;
    [self selectButton:_btns[type]];
}

#pragma mark - Method 

- (void)responseButtonActionForType:(ExpertType)type {
    self.type = type;
    if ([self.delegate respondsToSelector:@selector(findExpertByType:)]) {
        [self.delegate findExpertByType:type];
    }
}

- (void)selectButton:(UIButton *)button {
    for (UIButton *btn in _btns) {
        if (btn == button) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

@end
