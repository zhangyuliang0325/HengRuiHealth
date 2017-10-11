//
//  ArchivesCollectionViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Archive.h"

@interface ArchivesCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) Archive *archive;

- (void)loadCell;

@end
