//
//  ArchivePhotoSingleCollectionViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/11.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArhiveSingleCellDelegate <NSObject>

- (void)deleteImage:(UIImage *)image;

@end

@interface ArchivePhotoSingleCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) BOOL isHide;

@property (assign, nonatomic) id<ArhiveSingleCellDelegate> delegate;

- (void)loadCell;

@end
