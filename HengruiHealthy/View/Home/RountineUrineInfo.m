//
//  RountineUrineInfo.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/29.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "RountineUrineInfo.h"

@interface RountineUrineInfo () {
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UILabel *_lblPh;
    __weak IBOutlet UILabel *_lblDanbaizhi;
    __weak IBOutlet UILabel *_lblBaixibao;
    __weak IBOutlet UILabel *_lblNiaodanyuan;
    __weak IBOutlet UILabel *_lblYaxiaosuanyan;
}

@end

@implementation RountineUrineInfo

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configInfo {
    NSString *time = self.rountinUrine.measureTime;
    time = [NSString stringWithFormat:@"%@年%@月%@日 %@:%@", [time substringToIndex:4], [time substringWithRange:NSMakeRange(5, 2)], [time substringWithRange:NSMakeRange(8, 2)], [time substringWithRange:NSMakeRange(11, 2)], [time substringWithRange:NSMakeRange(14, 2)]];
    _lblTime.text = time;
    _lblBaixibao.text = self.rountinUrine.baixibao;
    _lblYaxiaosuanyan.text = self.rountinUrine.yaxiaosuanyan;
    _lblNiaodanyuan.text = self.rountinUrine.niaodanyuan;
    _lblDanbaizhi.text = self.rountinUrine.danbaizhi;
    _lblPh.text = self.rountinUrine.ph;

}

- (IBAction)antionForCancel:(UIButton *)sender {
    
    [self removeFromSuperview];
}

@end
