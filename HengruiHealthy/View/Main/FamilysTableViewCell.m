//
//  FamilysTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "FamilysTableViewCell.h"

@interface FamilysTableViewCell () {
    
    __weak IBOutlet UIButton *_btnAction;
    __weak IBOutlet UILabel *_lblMobile;
    __weak IBOutlet UILabel *_lblName;
}

@end

@implementation FamilysTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnAction.layer.borderColor = [UIColor orangeColor].CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCell {
    _lblName.text = self.family.nickName;
    _lblMobile.text = self.family.person.mobile;
    _btnAction.enabled = !self.family.isLogin;
    [self resizeButtonContent];
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedFamily:)]) {
        [self.delegate selectedFamily:self.family];
    }
}

- (void)resizeButtonContent {
    _btnAction.titleEdgeInsets = _btnAction.enabled ? UIEdgeInsetsMake(0, -10, 0, 10) : UIEdgeInsetsMake(0, -4, 0, 4);
    _btnAction.imageEdgeInsets = _btnAction.enabled ? UIEdgeInsetsMake(0, 31, 0, -31) : UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
