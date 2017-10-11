//
//  ArchiveDetailPhotoTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchiveDetailPhotoTableViewCell.h"

#import "ArchiveDetailCollectionViewCell.h"

@interface ArchiveDetailPhotoTableViewCell () <UICollectionViewDataSource> {
    __weak IBOutlet UICollectionView *_cvPhotos;
    __weak IBOutlet UICollectionViewFlowLayout *_layoutPhotos;
}

@end

static NSString *cellIdentifier = @"ArchiveDetailCollectionViewCell";

@implementation ArchiveDetailPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cvPhotos.delegate = (id)self;
    _cvPhotos.dataSource = (id)self;
//    CGFloat width = (HRHtyScreenWidth - 60) / 3;
    _layoutPhotos.sectionInset = UIEdgeInsetsMake(8, 15, 8, 15);
    _layoutPhotos.itemSize = CGSizeMake(60, 60);
    _layoutPhotos.minimumInteritemSpacing = 15;
    
}

- (void)loadCell {
    [_cvPhotos reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArchiveDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageURL = self.photos[indexPath.row];
    [cell loadCell];
    return cell;
}

#pragma mark - Collection view delegate

@end
