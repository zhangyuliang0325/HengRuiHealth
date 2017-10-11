//
//  HealthyArchiveListTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyArchiveListTableViewCell.h"

@interface HealthyArchiveListTableViewCell () {
    
    __weak IBOutlet NSLayoutConstraint *_consCode;
    __weak IBOutlet NSLayoutConstraint *_consDate;
    __weak IBOutlet UILabel *_lblDate;
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UILabel *_lblCode;
    __weak IBOutlet UIButton *_btnReview;
}

@end

@implementation HealthyArchiveListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnReview.layer.cornerRadius = 13;
    _btnReview.layer.borderColor = [UIColor orangeColor].CGColor;
    _btnReview.layer.borderWidth = 1;
    // Initialization code
}

- (void)loadCell {
    _lblDate.text = self.archive.date;
    _lblTime.text = self.archive.time;
    _lblCode.text = [NSString stringWithFormat:@"档案编号:%@", self.archive.archiveCode];
    _consDate.constant = self.dateLead;
    _consCode.constant = self.codeLead;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)actionForReviewButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(reviewArchive:)]) {
        [self.delegate reviewArchive:self.archive];
    }
}

@end
