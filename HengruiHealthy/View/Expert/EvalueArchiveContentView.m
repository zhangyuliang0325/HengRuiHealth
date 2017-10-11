//
//  EvalueArchiveContentView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EvalueArchiveContentView.h"

@interface EvalueArchiveContentView () {
    
    __weak IBOutlet UILabel *_lblEvalue;
}

@end

@implementation EvalueArchiveContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)loadView {
    _lblEvalue.text = self.content;
    _lblEvalue.frame = CGRectMake(10, 18, HRHtyScreenWidth - 80, FLT_MAX);
    [_lblEvalue sizeToFit];
    self.height = _lblEvalue.bounds.size.height + 28;
}

@end
