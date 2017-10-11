//
//  ArchiveDetailPhotoTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchiveDetailPhotoTableViewCell : UITableViewCell

@property (strong, nonatomic) NSArray *photos;

- (void)loadCell;

@end
