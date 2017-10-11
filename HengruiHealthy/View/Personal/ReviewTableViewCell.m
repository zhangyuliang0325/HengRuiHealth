//
//  ReviewTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ReviewTableViewCell.h"

@interface ReviewTableViewCell () {
    
    __weak IBOutlet UILabel *_lblEndLabel;
    __weak IBOutlet UIView *_vwNew;
    __weak IBOutlet UILabel *_lblEndTime;
}

@end

@implementation ReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblEndLabel.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)loadCell {
    [super loadCell];
    _vwNew.hidden = self.record.unreadCount == 0;
    _lblEndTime.text = [self.record.lastEvlueTime substringToIndex:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionForPromptExpert:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(prompt:)]) {
        [self.delegate prompt:self.record];
    }
}
- (IBAction)actionForDetail:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(detail:)]) {
        [self.delegate detail:self.record];
    }
}
- (IBAction)actionForComplete:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(complete:)]) {
        [self.delegate complete:self.record];
    }
}
- (IBAction)actionForReport:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(report:)]) {
        [self.delegate report:self.record];
    }
}

@end
