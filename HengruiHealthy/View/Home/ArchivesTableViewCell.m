//
//  ArchivesTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivesTableViewCell.h"

#import <objc/runtime.h>

@interface ArchivesTableViewCell<T> () {
    
    __weak IBOutlet UIButton *_btnInfo;
    __weak IBOutlet UILabel *_lblTime;
}

@end

@implementation ArchivesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadCell {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([self.t respondsToSelector:NSSelectorFromString(@"measureTime")]) {
            NSString *time = (NSString *)[self.t performSelector:NSSelectorFromString(@"measureTime")];
            time = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@", [time substringToIndex:4], [time substringWithRange:NSMakeRange(5, 2)], [time substringWithRange:NSMakeRange(8, 2)], [time substringWithRange:NSMakeRange(11, 2)], [time substringWithRange:NSMakeRange(14, 2)]];
            dispatch_async(dispatch_get_main_queue(), ^{
                _lblTime.text = time;
            });
        }
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)actionForCheckInfo:(UIButton *)sender {
    
}

@end
