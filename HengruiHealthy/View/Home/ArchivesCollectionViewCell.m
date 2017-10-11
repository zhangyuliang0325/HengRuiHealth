//
//  ArchivesCollectionViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivesCollectionViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ArchivesCollectionViewCell () {
    
    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UIImageView *_imgIcon;
}

@end

@implementation ArchivesCollectionViewCell

- (void)loadCell {
    _lblTitle.text = self.archive.title;
    _imgIcon.image = [UIImage imageNamed:self.archive.icon];
}

@end
