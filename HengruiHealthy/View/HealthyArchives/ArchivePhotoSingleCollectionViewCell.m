//
//  ArchivePhotoSingleCollectionViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/11.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivePhotoSingleCollectionViewCell.h"

@interface ArchivePhotoSingleCollectionViewCell () {
    
    __weak IBOutlet UIButton *_btnDelete;
    __weak IBOutlet UIImageView *_imgPhoto;
}

@end

@implementation ArchivePhotoSingleCollectionViewCell

- (void)loadCell {
    _imgPhoto.image = self.image;
    _btnDelete.hidden = self.isHide;
}
- (IBAction)deletePhoto:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteImage:)]) {
        [self.delegate deleteImage:self.image];
    }
}

@end
