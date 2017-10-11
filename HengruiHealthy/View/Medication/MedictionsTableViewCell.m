//
//  MedictionsTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MedictionsTableViewCell.h"

@interface MedictionsTableViewCell () {
    
    __weak IBOutlet UIButton *_btnReview;
    __weak IBOutlet UILabel *_lblFunc;
    __weak IBOutlet UILabel *lblSpec;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UIButton *_btnChoose;
}

@end

@implementation MedictionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCell {
    _lblName.text = self.medication.goodsName;
    lblSpec.text = self.medication.specification;
    _lblFunc.text = self.medication.profile;
    _btnChoose.selected = self.medication.isChoosed;
}

#pragma mark - Action

- (IBAction)actionForChooseButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegete respondsToSelector:@selector(chooseMedication:withState:)]) {
        [self.delegete chooseMedication:self.medication withState:sender.selected];
    }
}

- (IBAction)actionForReviewButton:(UIButton *)sender {
    if ([self.delegete respondsToSelector:@selector(reviewMedication:)]) {
        [self.delegete reviewMedication:_medication];
    }
}

@end
