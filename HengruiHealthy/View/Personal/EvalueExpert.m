//
//  EvalueExpert.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/22.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EvalueExpert.h"

#import "EvalueLabel.h"

@interface EvalueExpert () {
    
    __weak IBOutlet UIButton *_btnStar1;
    __weak IBOutlet UIButton *_btnStar2;
    __weak IBOutlet UIButton *_btnStar3;
    __weak IBOutlet UIButton *_btnStar4;
    __weak IBOutlet UIButton *_btnStar5;
    __weak IBOutlet UIView *_vwEvalueLabels;
    __weak IBOutlet NSLayoutConstraint *_consLabelsHeight;
    __weak IBOutlet UITextView *_txtContent;
    
    NSMutableArray *_chooseLabels;
    
    NSArray *_evalueButtons;
    NSMutableArray *_goodButtons;
    NSMutableArray *_badButtons;
    
    NSInteger _source;
    NSString *_evalueCategory;
}

@end

int _goodLabelButtonTagPrefix = 9000;
int _badLabelButtonTagPrefix = 8000;

NSString *const EVALUESTARCOUNT = @"evalue_expert_start_count";
NSString *const EVALUECONTENT = @"evalue_expert_content";
NSString *const EVALUELABELS = @"evalue_expert_labels";
NSString *const EVALUECATEGORY = @"evalue_expert_category";

@implementation EvalueExpert

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, HRHtyScreenWidth, HRHtyScreenHeight);
    _chooseLabels = [NSMutableArray array];
    _evalueButtons = [NSArray arrayWithObjects:_btnStar1, _btnStar2, _btnStar3, _btnStar4, _btnStar5, nil];
}


- (IBAction)actionForStar1:(UIButton *)sender {
    [self setEvalueSource:1];
}

- (IBAction)actionForStar2:(UIButton *)sender {
    [self setEvalueSource:2];
}

- (IBAction)actionForStar3:(UIButton *)sender {
    [self setEvalueSource:3];
}

- (IBAction)actionForStar4:(UIButton *)sender {
    [self setEvalueSource:4];
}

- (IBAction)actionForStar5:(UIButton *)sender {
    [self setEvalueSource:5];
}

- (IBAction)actionForCloseButton:(UIButton *)sender {
    [self removeFromSuperview];
}

- (IBAction)actionForEvalue:(UIButton *)sender {
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(submitEvalue:forRecord:)]) {
        NSMutableString *mStr = [NSMutableString string];
        for (int i = 0; i < _chooseLabels.count; i ++) {
            EvalueLabel *label = _chooseLabels[i];
            [mStr appendFormat:@"%@;", label.labelName];
        }
        [mStr deleteCharactersInRange:NSMakeRange(mStr.length, 1)];
        NSMutableDictionary *evlue = [NSMutableDictionary dictionary];
        evlue[EVALUELABELS] = mStr;
        evlue[EVALUECATEGORY] = _evalueCategory;
        evlue[EVALUESTARCOUNT] = @(_source);
        evlue[EVALUECONTENT] = _txtContent.text;
        [self.delegate submitEvalue:evlue forRecord:self.record];
    }
}

- (void)setEvalueSource:(NSInteger)source {
    for (int i = 0; i < _evalueButtons.count; i ++) {
        UIButton *button = _evalueButtons[i];
        button.selected = i < source;
    }
    _source = source;
}

- (void)configUI {
    _evalueCategory = nil;
    _source = 5;
    _txtContent.text = @"";
    [_evalueButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(YES)];
    [_vwEvalueLabels.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_goodButtons removeAllObjects];
    [_badButtons removeAllObjects];
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < self.goodEvalueLabels.count; i ++) {
        if (_goodButtons == nil) {
            _goodButtons = [NSMutableArray array];
        }
        EvalueLabel *goodLabel = self.goodEvalueLabels[i];
        UIButton *goodlabelButton = [self createButtonWithText:goodLabel.labelName color:[UIColor orangeColor]];
        CGFloat w = goodlabelButton.bounds.size.width + 6;
        CGFloat h = goodlabelButton.bounds.size.height + 3;
        if (x + w > HRHtyScreenWidth - 80) {
            x = 0;
            y = y + h + 5;
        }
        goodlabelButton.tag = _goodLabelButtonTagPrefix + i;
        goodlabelButton.frame = CGRectMake(x, y, w, h);
        [goodlabelButton addTarget:self action:@selector(actionForChooseGoodButton:) forControlEvents:UIControlEventTouchUpInside];
        [_vwEvalueLabels addSubview:goodlabelButton];
        [_goodButtons addObject:goodlabelButton];
        x = x + w + 5;
        if (i == self.goodEvalueLabels.count - 1) {
            y = y + h + 10;
        }
    }
    x = 0;
    for (int i = 0; i < self.badEvalueLabels.count; i ++) {
        if (_badButtons == nil) {
            _badButtons = [NSMutableArray array];
        }
        EvalueLabel *badLabel = self.badEvalueLabels[i];
        UIButton *badLabelButton = [self createButtonWithText:badLabel.labelName color:[UIColor lightGrayColor]];
        CGFloat w = badLabelButton.bounds.size.width + 6;
        CGFloat h = badLabelButton.bounds.size.height + 3;
        if (x + w > HRHtyScreenWidth - 80) {
            x = 0;
            y = y + h + 5;
        }
        badLabelButton.tag = _badLabelButtonTagPrefix + i;
        badLabelButton.frame = CGRectMake(x, y, w, h);
        [badLabelButton addTarget:self action:@selector(actionForChooseBadButton:) forControlEvents:UIControlEventTouchUpInside];
        [_vwEvalueLabels addSubview:badLabelButton];
        [_badButtons addObject:badLabelButton];
        x = x + w + 5;
        if (i == self.badEvalueLabels.count - 1) {
            _consLabelsHeight.constant = y + h + 10;
        }
    }
}

- (void)actionForChooseGoodButton:(UIButton *)sender {
    _evalueCategory = @"好评";
    sender.selected = !sender.selected;
     EvalueLabel *label = self.goodEvalueLabels[sender.tag - _goodLabelButtonTagPrefix];
    sender.backgroundColor = sender.selected ? [UIColor orangeColor] : [UIColor clearColor];
    if (sender.selected) {
//        [_badButtons makeObjectsPerformSelector:@selector(setEnabled:) withObject:@(0)];
        [_badButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.enabled = NO;
            obj.backgroundColor = [UIColor groupTableViewBackgroundColor];
            obj.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        }];
        [_chooseLabels addObject:label];
    } else {
        [_chooseLabels removeObject:label];
    }
    if (_chooseLabels.count == 0) {
//        [_badButtons makeObjectsPerformSelector:@selector(setEnabled:) withObject:@(1)];
        [_badButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.enabled = YES;
            obj.backgroundColor = [UIColor clearColor];
            obj.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }];
        _evalueCategory = nil;
    }
    
}

- (void)actionForChooseBadButton:(UIButton *)sender {
    _evalueCategory = @"差评";
    sender.selected = !sender.selected;
    EvalueLabel *label = self.badEvalueLabels[sender.tag - _badLabelButtonTagPrefix];
    sender.backgroundColor = sender.selected ? [UIColor lightGrayColor] : [UIColor clearColor];
    if (sender.selected) {
        [_chooseLabels addObject:label];
//        [_goodButtons makeObjectsPerformSelector:@selector(setEnabled:) withObject:@(0)];/
        [_goodButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.enabled = NO;
            obj.backgroundColor = [UIColor groupTableViewBackgroundColor];
            obj.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        }];
    } else {
        [_chooseLabels removeObject:label];
    }
    if (_chooseLabels.count == 0) {
//        [_goodButtons makeObjectsPerformSelector:@selector(setEnabled:) withObject:@(1)];
        [_goodButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.enabled = YES;
            obj.backgroundColor = [UIColor clearColor];
            obj.layer.borderColor = [UIColor orangeColor].CGColor;
        }];
        _evalueCategory = nil;
    }
}

- (UIButton *)createButtonWithText:(NSString *)text color:(UIColor *)color{
    UIButton *evlueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [evlueButton setTitle:text forState:UIControlStateNormal];
    [evlueButton setTitleColor:color forState:UIControlStateNormal];
    [evlueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [evlueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    evlueButton.layer.borderWidth = 1;
    evlueButton.layer.borderColor = color.CGColor;
    evlueButton.layer.cornerRadius = 2;
    [evlueButton sizeToFit];
    return evlueButton;
}
@end
