//
//  DateTypeViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "DateTypeViewCell.h"

@interface DateTypeViewCell () {
    
    __weak IBOutlet UILabel *_lblType;
}

@end

NSString *const typeViewColor = @"key_text_color";
NSString *const typeViewText = @"key_text_content";

@implementation DateTypeViewCell

- (void)loadCell {
    _lblType.text = self.type[typeViewText];
    _lblType.textColor = self.type[typeViewColor];
}

@end
