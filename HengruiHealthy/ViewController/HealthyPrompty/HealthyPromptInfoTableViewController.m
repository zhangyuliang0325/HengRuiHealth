//
//  HealthyPromptInfoTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/7.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyPromptInfoTableViewController.h"



@interface HealthyPromptInfoTableViewController () {
    
    __weak IBOutlet UILabel *_lblRepeat;
    __weak IBOutlet UILabel *_lblRing;
    __weak IBOutlet UISwitch *_swith;
    __weak IBOutlet UITextView *_txtRemark;
    
}

@end

@implementation HealthyPromptInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

- (IBAction)actionForSwitch:(UISwitch *)sender {
}

#pragma mark - Table view delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([self.delegate respondsToSelector:@selector(chooseWeekdays)]) {
                [self.delegate chooseWeekdays];
            }else if (indexPath.row == 1) {
                
            }
        }
    }
}

#pragma mark - UI

//- (void)configUI {
//    if (self.click == nil) {
//        return;
//    }
//    NSArray *repeatNames = (NSArray *)self.click.repeat_name;
//    NSMutableString *repeat = [NSMutableString string];
//    for (int i = 0; i < repeatNames.count; i ++) {
//        NSString *repeatName = repeatNames[i];
//        [repeat appendFormat:@"%@、", repeatName];
//    }
//    [repeat deleteCharactersInRange:NSMakeRange(repeat.length - 1, 1)];
//    _lblRepeat.text = repeat;
//    _lblRing.text = _click.sound;
//    _swith.on = _click.enable;
//}

- (void)setRecycle:(NSString *)recycle {
    _lblRepeat.text = recycle;
}

- (void)setRing:(NSString *)ring {
    _lblRing.text = ring;
}

- (void)setVibrating:(BOOL)isVibrating {
    _swith.on = isVibrating;
}

- (NSString *)getRemark {
    return _txtRemark.text;
}

@end
