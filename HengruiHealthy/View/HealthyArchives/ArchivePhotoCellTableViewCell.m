//
//  ArchivePhotoCellTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/11.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivePhotoCellTableViewCell.h"

#import "ArchivePhotoSingleCollectionViewCell.h"

@interface ArchivePhotoCellTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, ArhiveSingleCellDelegate> {
    
    __weak IBOutlet UICollectionViewFlowLayout *_layoutPhotos;
    __weak IBOutlet UICollectionView *_cvPhotos;
    
//    NSArray *_photos;
//    int _photoCount;
//    NSIndexPath *_indexPath;
}

@end

static NSString *collectionPhotoSingleCell = @"CollectionPhotoSingleCell";

NSString *const ARCHIVEPHOTOS = @"archive_photos";
NSString *const ARHCIVEPHOTOCOUNT = @"archive_photo_count";
NSString *const ARCHIVECELLPATH = @"archive_index_path";

@implementation ArchivePhotoCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _photos = [NSMutableArray array];
    _cvPhotos.delegate = (id)self;
    _cvPhotos.dataSource = (id)self;
    [_cvPhotos registerNib:[UINib nibWithNibName:@"ArchivePhotoSimpleCell" bundle:nil] forCellWithReuseIdentifier:collectionPhotoSingleCell];
    _layoutPhotos.sectionInset = UIEdgeInsetsMake(8, 8, 0, 8);
    _layoutPhotos.itemSize = CGSizeMake(60, 60);
    // Initialization code
}

- (void)loadCell {
    [_cvPhotos reloadData];
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArchivePhotoSingleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionPhotoSingleCell forIndexPath:indexPath];
    UIImage *image = _photos[indexPath.row];
    cell.image = image;
    cell.isHide = indexPath.row >= (int)_photoCount;
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == (int)_photoCount) {
        if ([self.delegate respondsToSelector:@selector(addPhotoInCell:)]) {
            [self.delegate addPhotoInCell:self];
        }
    }
}

#pragma mark - Archive single cell delegate

- (void)deleteImage:(UIImage *)image {
//    if ([self.delegate respondsToSelector:@selector(removePhoto:fromCell:)]) {
//        [self.delegate removePhoto:image fromCell:self];
//    }
    
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.photos];
    [mArr removeObject:image];
    self.photos = mArr;
    self.photoCount --;
    
    if ([self.delegate respondsToSelector:@selector(removePhotoFromCell:)]) {
        [self.delegate removePhotoFromCell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
