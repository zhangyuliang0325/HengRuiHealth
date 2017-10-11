//
//  HomeExpertTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HomeExpertTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeExpertTableViewCell () {
    
    __weak IBOutlet UIImageView *_imgAvatar;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblAptitude;
    __weak IBOutlet UILabel *_lblUtil;
    __weak IBOutlet UILabel *_lblSpeciality;
    __weak IBOutlet UIButton *_btnApointment;
}

@end

@implementation HomeExpertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnApointment.layer.borderColor = [UIColor orangeColor].CGColor;
    _btnApointment.layer.borderWidth = 1;
    _btnApointment.layer.cornerRadius = 15;
    // Initialization code
}

- (void)loadCell {
    NSURL *avatar = [NSURL URLWithString:self.expert.avatar];
    [_imgAvatar sd_setImageWithURL:avatar placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _lblName.text = self.expert.name;
    _lblUtil.text = self.expert.util;
    _lblAptitude.text = self.expert.aptitude;
    _lblSpeciality.text = self.expert.speciality;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Action

- (IBAction)actionForApointmentButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(apointmentExpert:)]) {
        [self.delegate apointmentExpert:self.expert];
    }
}


@end
