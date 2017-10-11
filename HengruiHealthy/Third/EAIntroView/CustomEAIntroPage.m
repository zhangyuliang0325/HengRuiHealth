//
//  CustomEAIntroPage.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "CustomEAIntroPage.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface CustomEAIntroPage () {
    
    __weak IBOutlet UIImageView *_imageView;
}

@end

@implementation CustomEAIntroPage

- (void)loadImage {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:[UIImage imageNamed:@""]];
}

@end
