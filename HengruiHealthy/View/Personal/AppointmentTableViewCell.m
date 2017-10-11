
//
//  AppointmentTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentTableViewCell.h"

#import "CheckStringManager.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface AppointmentTableViewCell () {
    
    __weak IBOutlet UILabel *_lblStartLabel;
    __weak IBOutlet UIImageView *_imgAvatar;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblDutail;
    __weak IBOutlet UILabel *_lblArea;
    __weak IBOutlet UILabel *_lblCode;
    __weak IBOutlet UILabel *_lblStartTime;
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UIImageView *_imgStar1;
    __weak IBOutlet UIImageView *_imgStar2;
    __weak IBOutlet UIImageView *_imgStar3;
    __weak IBOutlet UIImageView *_imgStar4;
    __weak IBOutlet UIImageView *_imgStar5;
    NSArray *_stars;
}

@end

@implementation AppointmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblStartLabel.layer.borderColor = [UIColor redColor].CGColor;
    _stars = [NSArray arrayWithObjects:_imgStar1, _imgStar2, _imgStar3, _imgStar4, _imgStar5, nil];
    // Initialization code
}

- (void)loadCell {
    SDWebImageDownloader *downloader = [SDWebImageManager sharedManager].imageDownloader;
    [downloader setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken]forHTTPHeaderField:@"Cookie"];
    [downloader downloadImageWithURL:[NSURL URLWithString:self.record.expert.avatar] options:SDWebImageDownloaderHandleCookies progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _imgAvatar.image = image;
    }];
    for (int i = 0; i < _stars.count; i ++) {
        UIImageView *imageStar = _stars[i];
        if (i < self.record.starCount) {
            imageStar.image = [UIImage imageNamed:@"good_star"];
        } else {
            imageStar.image = [UIImage imageNamed:@"bad_star"];
        }
    }
    NSLog(@"record id %@", self.record.recordId);
    if ([self.record.recordId isEqualToString:@"32F0B64A-727C-44A5-8A48-2C8EF77735E"]) {
        self.contentView.backgroundColor = [UIColor blueColor];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    _lblName.text = self.record.expert.name;
    _lblDutail.text = self.record.expert.duties;
    _lblArea.text = self.record.expert.aptitude;
    _lblCode.text = [NSString stringWithFormat:@"预约单号:%@", self.record.friendlyId];
    _lblStartTime.text = [self.record.createTime substringToIndex:10];
    _lblPrice.text = [NSString stringWithFormat:@"¥ %@", [CheckStringManager checkBlankString:self.record.realPay] ? @"0.00" : self.record.realPay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
