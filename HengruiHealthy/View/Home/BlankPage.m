//
//  BlankPage.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/21.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "BlankPage.h"

@interface BlankPage () {
    
    __weak IBOutlet UILabel *_lblPrompt;
}

@end

@implementation BlankPage

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblPrompt.text = @"没有检测记录\n点击重新获取";
}
- (IBAction)clickRetryButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(retry)]) {
        [self.delegate retry];
    }
}

@end
