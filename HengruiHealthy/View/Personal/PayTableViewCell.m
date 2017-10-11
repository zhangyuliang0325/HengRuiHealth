//
//  PayTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PayTableViewCell.h"

@interface PayTableViewCell () {
    
}

@end

@implementation PayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)actionForPay:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pay:)]) {
        [self.delegate pay:self.record];
    }
}

@end
