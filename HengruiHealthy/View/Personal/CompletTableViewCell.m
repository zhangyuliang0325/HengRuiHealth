//
//  CompletTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "CompletTableViewCell.h"

@interface CompletTableViewCell () {
    
    __weak IBOutlet UILabel *_lblEndLabel;
    __weak IBOutlet UILabel *_lblEndTime;
}

@end

@implementation CompletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblEndLabel.layer.borderColor = [UIColor redColor].CGColor;
    // Initialization code
}

- (void)loadCell {
    [super loadCell];
    _lblEndTime.text = [self.record.lastEvlueTime substringToIndex:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)actionForDetail:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(detail:)]) {
        [self.delegate detail:self.record];
    }
}
- (IBAction)actionForEvalue:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(evalue:)]) {
        [self.delegate evalue:self.record];
    }
}
- (IBAction)actionForService:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(service:)]) {
        [self.delegate service:self.record];
    }
}

@end
