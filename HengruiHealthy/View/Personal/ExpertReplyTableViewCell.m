//
//  ExpertReplyTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertReplyTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ExpertReplyTableViewCell () {
    
    __weak IBOutlet UIImageView *_imgExpert;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblDutail;
    __weak IBOutlet UILabel *_lblReply;
    __weak IBOutlet UILabel *_lblTime;
}

@end

@implementation ExpertReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadCell {
    SDWebImageDownloader *downloader = [SDWebImageManager sharedManager].imageDownloader;
    [downloader setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken] forHTTPHeaderField:@"Cookie"];
    [downloader downloadImageWithURL:[NSURL URLWithString:self.expert.avatar] options:SDWebImageDownloaderHandleCookies progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _imgExpert.image = image;
    }];
    _lblName.text = self.reply.remarkerName;
    _lblDutail.text = self.expert.duties;
    _lblReply.text = self.reply.remarkContent;
    _lblTime.text = [NSString stringWithFormat:@"%@ %@", [self.reply.createTime substringToIndex:10], [self.reply.createTime substringWithRange:NSMakeRange(12, 8)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
