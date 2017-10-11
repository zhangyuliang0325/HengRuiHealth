//
//  AppointmentArchiveTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/25.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentArchiveTableViewCell.h"

@interface AppointmentArchiveTableViewCell () {
    
    __weak IBOutlet UIButton *_btnReview;
    __weak IBOutlet UILabel *_lblCode;
    __weak IBOutlet UIButton *_btnChoose;
}

@end

@implementation AppointmentArchiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnReview.layer.borderColor = [UIColor orangeColor].CGColor;
    _btnReview.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCell {
    _lblCode.text = self.archive.archiveCode;
    _btnChoose.selected = self.archive.choosed;
}

- (IBAction)actionForReviewButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(reviewArchive:)]) {
        [self.delegate reviewArchive:self.archive];
    }
}

- (IBAction)actionForChooseButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(chooseArchive:select:)]) {
        sender.selected = [self.delegate chooseArchive:self.archive select:!sender.selected];
        self.archive.choosed = sender.selected;
    }
}

@end
