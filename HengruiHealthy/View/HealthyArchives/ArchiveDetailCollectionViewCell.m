
//
//  ArchiveDetailCollectionViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchiveDetailCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@interface ArchiveDetailCollectionViewCell () {
    __weak IBOutlet UIImageView *_photo;
}

@end

@implementation ArchiveDetailCollectionViewCell

- (void)loadCell {
    
    NSURL *URL = [NSURL URLWithString:self.imageURL];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:URL];
    [mRequest setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie_token"]forHTTPHeaderField:@"Cookie"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:mRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            UIImage *imag = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                _photo.image = imag;
            });
        }
    }];
    [task resume];
}

@end
