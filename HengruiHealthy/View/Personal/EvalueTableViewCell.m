//
//  EvalueTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/18.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EvalueTableViewCell.h"

#import "ExpertEvalueLabel.h"

#import "ExpertClient.h"
#import <MJExtension.h>

@interface EvalueTableViewCell () {
    
    __weak IBOutlet UIView *_vwLabels;
    __weak IBOutlet UILabel *_lblEndLabel;
    __weak IBOutlet UILabel *_lblEndTime;
    __weak IBOutlet UITextView *_txtRemark;
    __weak IBOutlet NSLayoutConstraint *_consLabels;
    
    NSArray *_evalues;
}

@end

@implementation EvalueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblEndLabel.layer.borderColor = [UIColor redColor].CGColor;
    // Initialization code
}

- (void)loadCell {
    [super loadCell];
    [self getEvalues];
    [_vwLabels.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _lblEndTime.text = [self.record.lastEvlueTime substringToIndex:10];
    _txtRemark.text = self.record.remark;
//    NSArray *evalues = [self.record.evalueLabel componentsSeparatedByString:@";"];
//    CGFloat x = 15;
//    CGFloat y = 5;
//    for (int i = 0; i < evalues.count; i ++) {
//        NSString *content = evalues[i];
//        UILabel *label = [[UILabel alloc] init];
//        label.text = content;
//        [label sizeToFit];
//        CGFloat w = label.bounds.size.width + 8;
//        CGFloat h = label.bounds.size.height + 8;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor colorWithRed:60.0/255 green:61.0/255 blue:65.0/255 alpha:1];
//        label.layer.cornerRadius = 2;
//        label.layer.borderColor = [UIColor colorWithRed:124.0/255 green:123.0/255 blue:123.0/255 alpha:1].CGColor;
//        label.layer.borderWidth = 1;
//        label.clipsToBounds = YES;
//        if (x + w > HRHtyScreenWidth) {
//            x = 15;
//            y = y + h + 5;
//        }
//        label.frame = CGRectMake(x, y, w, h);
//        x = x + w + 8;
//        [_vwLabels addSubview:label];
//        if (i == evalues.count - 1) {
//            _consLabels.constant = y + h + 5;
//        }
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)actionForDetail:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(detail:)]) {
        [self.delegate detail:self.record];
    }
}
- (IBAction)actionForService:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(service:)]) {
        [self.delegate service:self.record];
    }
}

- (void)getEvalues {
    [[ExpertClient shartInstance] getExpertEvalueLabel:self.record.expertId handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            _evalues = [ExpertEvalueLabel mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            [self configEvalues];
        } else {
            
        }
    }];
}

- (void)configEvalues {
    CGFloat x = 15;
    CGFloat y = 8;
    for (int i = 0; i < _evalues.count; i ++) {
        ExpertEvalueLabel *evalue = _evalues[i];
        UILabel *label = [[UILabel alloc] init];
        label.text = evalue.labelContent;
        label.textColor =[UIColor lightGrayColor];
        [label sizeToFit];
        CGFloat w = label.bounds.size.width + 8;
        CGFloat h  = label.bounds.size.height + 4;
        if (w + x > HRHtyScreenWidth) {
            x = 15;
            y = y + h + 5;
        }
        label.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 2;
        label.frame = CGRectMake(x, y, w, h);
        [_vwLabels addSubview:label];
        x = x + w + 10;
        if (i == _evalues.count - 1) {
            _consLabels.constant = y + h + 8;
            if (self.reloadEvalueCell) {
                self.reloadEvalueCell(_consLabels.constant + 342, self.indexPath);
            }
        }
    }
}

@end
