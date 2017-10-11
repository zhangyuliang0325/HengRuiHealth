//
//  AttachReplyTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AttachReplyTableViewCell.h"

@interface AttachReplyTableViewCell () {
    
    __weak IBOutlet UILabel *_lblReplyType;
    __weak IBOutlet UILabel *_lblReplyContent;
    __weak IBOutlet UILabel *_lblReplyTime;
}

@end

@implementation AttachReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadCell {
    _lblReplyContent.text = self.reply.remarkContent;
    _lblReplyTime.text = [NSString stringWithFormat:@"%@ %@", [self.reply.createTime substringToIndex:10], [self.reply.createTime substringWithRange:NSMakeRange(12, 8)]];
    _lblReplyType.text = [self.reply.remarkerType isEqualToString:@"患者"] ? @"追问:" : @"回答:";

    _lblReplyType.textColor = [self.reply.remarkerType isEqualToString:@"患者"] ? [UIColor colorWithRed:168.0/255 green:205.0/255 blue:92.0/255 alpha:1] : [UIColor colorWithRed:34.0/255 green:184.0/255 blue:208.0/255 alpha:1];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
