//
//  SystemMessageTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "SystemMessageTableViewCell.h"

@interface SystemMessageTableViewCell () {
    
    
    __weak IBOutlet UILabel *_lblContent;
    __weak IBOutlet UIView *_vwNew;
}

@end

@implementation SystemMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.checkBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)actionForReviewButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(checkNowButtonClick:)]) {
        [self.delegate checkNowButtonClick:sender];
    }
}

- (void)loadCell {
    _lblContent.text = [NSString stringWithFormat:@"您于%@收到一条%@", [_message.createTime substringToIndex:10], _message.messageTextContent];
    _vwNew.hidden = self.message.isRead;
}

@end
