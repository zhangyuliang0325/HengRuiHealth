//
//  DateTypeView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "DateTypeView.h"

#import "DateTypeViewCell.h"

@interface DateTypeView () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    __weak IBOutlet NSLayoutConstraint *_constaintsSlideCenter;
    __weak IBOutlet UICollectionViewFlowLayout *_layoutType;
    __weak IBOutlet UIView *_vwSlide;
    __weak IBOutlet UICollectionView *_cvType;
    
    NSMutableArray *_dicTypes;
    NSInteger _distance;
}

@end

static NSString *dateTypeCellIdentifier = @"DateTypeCellIdentifier";

@implementation DateTypeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)configView {
    [self initCollectionView];
    [self initCollectionLayout];
    [_cvType reloadData];
}

- (void)initCollectionView {
    _cvType.delegate = (id)self;
    _cvType.dataSource = (id)self;
    [_cvType registerNib:[UINib nibWithNibName:@"DateTypeViewCell" bundle:nil] forCellWithReuseIdentifier:dateTypeCellIdentifier];
}

- (void)initCollectionLayout {
    _layoutType.itemSize = CGSizeMake(_distance, _cvType.bounds.size.height - 2);
    _layoutType.minimumLineSpacing = 0;
    _layoutType.minimumInteritemSpacing = 0;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self changeConstaintContent:indexPath.row];
    [UIView animateWithDuration:0.3 animations:^{
        [self setNeedsLayout];
    }];
    switch (indexPath.row) {
        case 0:
            self.flag = NSCalendarUnitDay;
            break;
        case 1:
            self.flag = NSCalendarUnitWeekOfMonth;
            break;
        case 2:
            self.flag = NSCalendarUnitMonth;
            break;
        default:
            break;
    }
    self.selectIndex = indexPath.row;
    [_cvType reloadData];
    if ([self.delegate respondsToSelector:@selector(changeToDateFlag:)]) {
        [self.delegate changeToDateFlag:self.flag];
    }
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.types.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DateTypeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dateTypeCellIdentifier forIndexPath:indexPath];
    cell.type = _dicTypes[indexPath.row];
    [cell loadCell];
    return cell;
}

#pragma mark - setter

- (void)setTypes:(NSArray *)types {
    _types = types;
    _dicTypes = [NSMutableArray array];
    [types enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dicType = [[NSMutableDictionary alloc] init];
        UIColor *textColor = [UIColor darkTextColor];
        dicType[typeViewColor] = textColor;
        dicType[typeViewText] = obj;
        [_dicTypes addObject:dicType];
    }];
    _distance = HRHtyScreenWidth / types.count;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    [_dicTypes enumerateObjectsUsingBlock:^(NSMutableDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj[typeViewColor] = [UIColor darkTextColor];
        if (idx == selectIndex) {
            obj[typeViewColor] = [UIColor orangeColor];
        }
    }];
    [self changeConstaintContent:selectIndex];
}

#pragma mark - Method

- (void)changeConstaintContent:(NSInteger)index {
    float center = _distance * index + _distance / 2;
    _constaintsSlideCenter.constant = center - HRHtyScreenWidth / 2;

}

@end
