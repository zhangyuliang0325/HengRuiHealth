//
//  OverdueTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "OverdueTableViewCell.h"

@interface OverdueTableViewCell () {
    
}

@end

@implementation OverdueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionForService:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(service:)]) {
        [self.delegate service:self.record];
    }
}
- (IBAction)actionForDetail:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(detail:)]) {
        [self.delegate detail:self.record];
    }
}
@end
