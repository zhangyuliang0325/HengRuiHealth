//
//  HealthyArchiveListFooter.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyArchiveListFooter.h"

@interface HealthyArchiveListFooter () {
    
    __weak IBOutlet UIButton *_btnAdd;
}

@end

@implementation HealthyArchiveListFooter

- (IBAction)actionForAddButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addArchiveFooter)]) {
        [self.delegate addArchiveFooter];
    }
}

@end
