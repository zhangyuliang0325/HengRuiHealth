//
//  BlankHealthyArchiveList.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "BlankHealthyArchiveList.h"

@interface BlankHealthyArchiveList () {
    
    __weak IBOutlet UIButton *_btnAdd;
    __weak IBOutlet UILabel *_lblMessage;
}

@end

@implementation BlankHealthyArchiveList

- (IBAction)actionForAddButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addArchiveBlank)]) {
        [self.delegate addArchiveBlank];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [_btnAdd setTitle:title forState:UIControlStateNormal];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _lblMessage.text = message;
}

- (void)setIsHideButton:(BOOL)isHideButton {
    _isHideButton = isHideButton;
    _btnAdd.hidden = isHideButton;
}

- (void)setIsHideMessage:(BOOL)isHideMessage {
    _isHideMessage = isHideMessage;
    _lblMessage.hidden = isHideMessage;
}

@end
