//
//  ExpertSearchView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertSearchView.h"

@interface ExpertSearchView () <UITextFieldDelegate> {
    
    __weak IBOutlet UITextField *_tfSearch;
}

@end

@implementation ExpertSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    _tfSearch.delegate = (id)self;
}

#pragma mark - Text field delegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchExpert:)]) {
        [self.delegate searchExpert:textField.text];
    }
}

@end
