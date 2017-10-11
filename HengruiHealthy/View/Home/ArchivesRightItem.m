//
//  ArchivesRightItem.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivesRightItem.h"

#import "ArchivesActionSheetManager.h"

@interface ArchivesRightItem () {
    
    __weak IBOutlet UIButton *_btnArchive;
    __weak IBOutlet UILabel *_lblTitle;
}

@end

@implementation ArchivesRightItem

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 3;
}

- (IBAction)actionForChooseArchivesButton:(UIButton *)sender {
    ArchivesActionSheetManager *manager = [[ArchivesActionSheetManager alloc] initWithController:self.vc];
    [manager showActionSheet];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _lblTitle.text = title;
    [_lblTitle sizeToFit];
    
    CGFloat w = _lblTitle.bounds.size.width + 20;
    self.frame = CGRectMake(0, 0, w, 30);
}

@end
