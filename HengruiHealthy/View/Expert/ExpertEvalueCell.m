//
//  ExpertEvalueCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertEvalueCell.h"

#import "EvalueArchiveContentView.h"

#import "HealthyArchive.h"

#import "CheckStringManager.h"

@interface ExpertEvalueCell () {
    
    __weak IBOutlet UIButton *_star1;
    __weak IBOutlet UIButton *_star2;
    __weak IBOutlet UIButton *_star3;
    __weak IBOutlet UIButton *_star4;
    __weak IBOutlet UIButton *_star5;
    __weak IBOutlet UILabel *_lblname;
    __weak IBOutlet UILabel *_lblContent;
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UIView *_vwArchive;
    __weak IBOutlet NSLayoutConstraint *_consHeight;
    
    NSMutableArray *_stars;
}

@end

@implementation ExpertEvalueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _stars = [NSMutableArray array];
    [_stars addObject:_star5];
    [_stars addObject:_star4];
    [_stars addObject:_star3];
    [_stars addObject:_star2];
    [_stars addObject:_star1];
}

- (void)loadCell {
    [_stars enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = idx < _content.starCount;
    }];
    _lblname.text = [NSString stringWithFormat:@"昵称:%@", _content.name];
    [_lblname sizeToFit];
    CGFloat nameHeight = _lblname.bounds.size.height;
    _lblContent.text = _content.content;
    [_lblContent sizeToFit];
    CGFloat contentHeight = _lblContent.bounds.size.height;
    _lblTime.text = _content.time;
    [_lblTime sizeToFit];
    CGFloat timeHeight = _lblTime.bounds.size.height;
    __block CGFloat y = 0;
    CGFloat w = HRHtyScreenWidth - 60;
    if (_vwArchive.subviews.count == 0) {
        [_content.archives enumerateObjectsUsingBlock:^(HealthyArchive *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![CheckStringManager checkBlankString:obj.baseInfo]) {
                EvalueArchiveContentView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"EvalueArchiveContentView" owner:self options:nil] lastObject];
                contentView.frame = CGRectMake(0, y, w, 100);
                contentView.content = obj.baseInfo;
                [contentView loadView];
                contentView.frame = CGRectMake(0, y, w, contentView.height);
                [_vwArchive addSubview:contentView];
                _consHeight.constant = y + contentView.height;
                self.cellHeight = _consHeight.constant + nameHeight + contentHeight + timeHeight + 57;
                y = y + contentView.height + 8;
            }
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
