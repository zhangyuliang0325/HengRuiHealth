//
//  AddMedicationTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AddMedicationTableViewCell.h"

#import "CheckStringManager.h"
#import "MBPrograssManager.h"

@interface AddMedicationTableViewCell () <UITextFieldDelegate> {
    
    __weak IBOutlet UIButton *_btnDelete;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblCategory;
    __weak IBOutlet UILabel *_lblSpec;
    __weak IBOutlet UIButton *_btnMorning;
    __weak IBOutlet UIButton *_btnAfternoon;
    __weak IBOutlet UIButton *_btnEvening;
    __weak IBOutlet UILabel *_lblUnit1;
    __weak IBOutlet UILabel *_lblUnit2;
    __weak IBOutlet UILabel *_lblUnit3;
    __weak IBOutlet UITextField *_tfMorning;
    __weak IBOutlet UITextField *_tfAfternoon;
    __weak IBOutlet UITextField *_tfEvening;
    
    UIView *_inputAccesoryView;
    
    MedicationInteval _interval;
}

@end

@implementation AddMedicationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configAccessoryView];
    _tfMorning.delegate = self;
    _tfAfternoon.delegate = (id)self;
    _tfEvening.delegate = (id)self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCell {
    _lblName.text = self.medication.medication.goodsName;
    _lblCategory.text = @"";
    _lblSpec.text = self.medication.medication.specification;
    _lblUnit1.text = _lblUnit2.text = _lblUnit3.text = [NSString stringWithFormat:@"%@/次", self.medication.medication.unit];
    _btnMorning.selected = self.medication.isMorning;
    _tfMorning.text = self.medication.morningCount;
    _btnAfternoon.selected = self.medication.isAfternoon;
    _tfAfternoon.text = self.medication.afternoonCount;
    _btnEvening.selected = self.medication.isEvening;
    _tfEvening.text = self.medication.eveningCount;
}

#pragma mark - Action

- (IBAction)actionForDelete:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteMedication:)]) {
        [self.delegate deleteMedication:self.medication];
    }
}

- (IBAction)actionForMorningButton:(UIButton *)sender {
    if (sender.selected == NO) {
        _interval = medicaitonAtMorning;
        if ([_tfMorning.text integerValue] == 0) {
            [_tfMorning becomeFirstResponder];
        } else {
            sender.selected = YES;
        }
    } else {
        sender.selected = NO;
        self.medication.isMorning = NO;
    }
}

- (IBAction)actionForAfternoonButton:(UIButton *)sender {
    if (sender.selected == NO) {
        _interval = medicationAtAfternoon;
        if ([_tfAfternoon.text integerValue] == 0) {
            [_tfAfternoon becomeFirstResponder];
        } else {
            sender.selected = YES;
        }
    } else {
        sender.selected = NO;
        self.medication.isAfternoon = NO;
    }

}

- (IBAction)actionForEveningButton:(UIButton *)sender {
    if (sender.selected == NO) {
        _interval = medicationAtEvening;
        if ([_tfEvening.text integerValue] == 0) {
            [_tfEvening becomeFirstResponder];
        } else {
            sender.selected = YES;
        }
    } else {
        sender.selected = NO;
        self.medication.isEvening = NO;
    }
}

- (IBAction)actionForReviewButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(reviewMedication:)]) {
        [self.delegate reviewMedication:self.medication];
    }
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _tfMorning) {
        _interval = medicaitonAtMorning;
    } else if (textField == _tfAfternoon) {
        _interval = medicationAtAfternoon;
    } else {
        _interval = medicationAtEvening;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text integerValue] == 0) {
        [MBPrograssManager showMessageOnMainView:@"请输入服药剂量"];
        return;
    }
    switch (_interval) {
        case medicaitonAtMorning:
            _btnMorning.selected = YES;
            self.medication.morningCount = textField.text;
            self.medication.isMorning = YES;
            break;
        case medicationAtAfternoon:
            _btnAfternoon.selected = YES;
            self.medication.afternoonCount = textField.text;
            self.medication.isAfternoon = YES;
            break;
        case medicationAtEvening:
            _btnEvening.selected = YES;
            self.medication.eveningCount = textField.text;
            self.medication.isEvening = YES;
            break;
        default:
            break;
    }
}

#pragma mark - UI

- (void)configAccessoryView {
    _inputAccesoryView = [[UIView alloc] init];
    _inputAccesoryView.frame = CGRectMake(0, 0, HRHtyScreenWidth, 30);
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel sizeToFit];
    cancel.frame = CGRectMake(8, 0, cancel.bounds.size.width, 30);
    [cancel addTarget:self action:@selector(actionForCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [_inputAccesoryView addSubview:cancel];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure sizeToFit];
    sure.frame = CGRectMake(HRHtyScreenWidth - sure.bounds.size.width - 8, 0, sure.bounds.size.width, 30);
    [sure addTarget:self action:@selector(actionForSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [_inputAccesoryView addSubview:sure];
}

#pragma mark - Method

- (void)actionForCancelButton:(UIButton *)sender {
    
}

- (void)actionForSureButton:(UIButton *)sender {
    
}

@end
