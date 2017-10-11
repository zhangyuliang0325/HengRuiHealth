//
//  ExpertListTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertListTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ExpertListTableViewCell () {
    
    __weak IBOutlet UILabel *_lblSubname;
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UIImageView *_imgAvatar;
    __weak IBOutlet UILabel *_lblArea;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblHospital;
}

@end

@implementation ExpertListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadCell {
    [_imgAvatar sd_setImageWithURL:[NSURL URLWithString:self.expert.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _lblHospital.text = self.expert.util;
    _lblName.text = self.expert.name;
    _lblSubname.text = [NSString stringWithFormat:@"%@ %@", self.expert.level, self.expert.duties];
    _lblArea.text = self.expert.speciality;
    _lblPrice.text = [NSString stringWithFormat:@"¥ %.2f", self.expert.price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
