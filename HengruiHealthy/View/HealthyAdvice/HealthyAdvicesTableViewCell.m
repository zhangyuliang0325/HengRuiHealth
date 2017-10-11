//
//  HealthyAdvicesTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyAdvicesTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface HealthyAdvicesTableViewCell () {
    
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UIImageView *_imgAvatar;
    __weak IBOutlet UIView *_vwNew;
    __weak IBOutlet UILabel *_lblLevel;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UIButton *_btnReview;
    __weak IBOutlet NSLayoutConstraint *_consWidht;
}

@end

@implementation HealthyAdvicesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnReview.layer.borderColor = [UIColor orangeColor].CGColor;
    _lblLevel.layer.borderColor = [UIColor colorWithRed:92.0/255 green:169.0/255 blue:197.0/255 alpha:1].CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Action

- (IBAction)actionForReviewButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(reviewAdvice:)]) {
        [self.delegate reviewAdvice:self.advice];
    }
}

#pragma mark - Method

- (void)loadCell {
    _lblName.text = self.advice.expert.name;
    _lblTime.text = [self.advice.time substringToIndex:10];
    _vwNew.hidden = self.advice.isRead;
    SDWebImageDownloader *downloder = [SDWebImageManager sharedManager].imageDownloader;
    [downloder setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken] forHTTPHeaderField:@"Cookie"];
    [downloder downloadImageWithURL:[NSURL URLWithString:self.advice.expert.avatar] options:SDWebImageDownloaderHandleCookies progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _imgAvatar.image = image;
    }];
    _lblLevel.text = self.advice.expert.duties;
    [_lblLevel sizeToFit];
    _consWidht.constant = _lblLevel.bounds.size.width + 8;
}

@end
