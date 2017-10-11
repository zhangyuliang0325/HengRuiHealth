//
//  ArchivePhotoCellTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/11.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArchivePhotoCellDelegate;

@interface ArchivePhotoCellTableViewCell : UITableViewCell

FOUNDATION_EXTERN NSString *const ARCHIVEPHOTOS;
FOUNDATION_EXTERN NSString *const ARHCIVEPHOTOCOUNT;
FOUNDATION_EXTERN NSString *const ARCHIVECELLPATH;

//@property (strong, nonatomic) NSDictionary *source;

@property (strong, nonatomic) NSArray *photos;
@property (assign, nonatomic) int photoCount;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (assign, nonatomic) id<ArchivePhotoCellDelegate> delegate;

- (void)loadCell;

@end

@protocol ArchivePhotoCellDelegate <NSObject>

- (void)addPhotoInCell:(UITableViewCell *)cell;
//- (void)removePhoto:(UIImage *)image fromCell:(ArchivePhotoCellTableViewCell *)cell;
- (void)removePhotoFromCell:(ArchivePhotoCellTableViewCell *)cell;

@end
