//
//  HealthyPromptsTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyPromptsTableViewCell.h"

@interface HealthyPromptsTableViewCell () {
    
    __weak IBOutlet UISwitch *_swithClick;
    __weak IBOutlet UILabel *_lblInterval;
    __weak IBOutlet UILabel *_lblRecycle;
    __weak IBOutlet UILabel *_lblTime;
}

@end

@implementation HealthyPromptsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Action

- (IBAction)actionForClickSwith:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(openPrompt:isOpen:)]) {
        [self.delegate openPrompt:self.item isOpen:sender.on];
    }
}

#pragma mark - UI

- (void)loadCell {
//    NSString *hour = _item.hour >= 10 ? [NSString stringWithFormat:@"%d", _item.hour] : [NSString stringWithFormat:@"0%d", _item.hour];
//    NSString *minite = _item.minite >= 10 ? [NSString stringWithFormat:@"%d", _item.minite] : [NSString stringWithFormat:@"0%d", _item.minite];
//    _lblTime.text = [NSString stringWithFormat:@"%@%@", hour, minite];
//    NSArray *repeatNames = (NSArray *)_item.repeat_name;
//    NSMutableString *repeat = [NSMutableString string];
//    for (int i = 0; i < repeatNames.count; i ++) {
//        NSString *repeatName = repeatNames[i];
//        [repeat appendFormat:@"%@、", repeatName];
//    }
//    [repeat deleteCharactersInRange:NSMakeRange(repeat.length - 1, 1)];
//    _lblRecycle.text = repeat;
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSDate *fireDate = [calendar dateBySettingHour:_item.hour minute:_item.minite second:0 ofDate:[NSDate date] options:NSCalendarMatchStrictly];
//    NSDateComponents *intervalComponents = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date] toDate:fireDate options:NSCalendarWrapComponents];
//    _lblInterval.text = [NSString stringWithFormat:@"%ld小时%ld分钟后响铃", (long)intervalComponents.hour, (long)intervalComponents.minute];
//    _swithClick.on = _item.enable;
    _swithClick.on = self.item.isEnable;
    _lblTime.text = [self.item.promptTime substringToIndex:5];
    _lblRecycle.text = self.item.weekdays;
    NSDate *now = [NSDate date];
    NSInteger hour = [[self.item.promptTime substringToIndex:2] integerValue
    ];
    NSInteger minute = [[self.item.promptTime substringFromIndex:3] integerValue];
    NSDate *promptDate = [[NSCalendar currentCalendar] dateBySettingHour:hour minute:minute second:0 ofDate:now options:NSCalendarSearchBackwards];
    if ([promptDate compare:now] == NSOrderedAscending) {
        promptDate = [promptDate dateByAddingTimeInterval:86400];
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:now toDate:promptDate options:NSCalendarWrapComponents];
    _lblInterval.text = [NSString stringWithFormat:@"距下次提醒还有%ld天%ld小时%ld分钟", (long)components.day, (long)components.hour, (long)components.minute];
}

@end
