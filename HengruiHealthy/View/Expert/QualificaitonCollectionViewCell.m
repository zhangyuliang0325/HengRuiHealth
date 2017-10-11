//
//  QualificaitonCollectionViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/23.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "QualificaitonCollectionViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface QualificaitonCollectionViewCell () {
    
    __weak IBOutlet UIImageView *_imgQualification;
}
@end

@implementation QualificaitonCollectionViewCell

- (void)loadCell {
    SDWebImageDownloader *downloader = [SDWebImageManager sharedManager].imageDownloader;
    [downloader setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId]forHTTPHeaderField:@"Cookie"];
    [downloader downloadImageWithURL:[NSURL URLWithString:self.url] options:SDWebImageDownloaderHandleCookies progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _imgQualification.image = image;
    }];
}
@end
