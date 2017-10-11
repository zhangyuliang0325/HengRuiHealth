//
//  PersonInfoTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PersonInfoTableViewController.h"

#import "Person.h"

#import "PersonClient.h"

#import "PersonInfoTableViewController+PersonInfoManager.h"
#import "PersonInfoPickerProtocal.h"

#import "CheckStringManager.h"
#import "AlertManager.h"
#import "MBPrograssManager.h"
#import <MJRefresh/MJRefresh.h>
#import <MJExtension.h>
@interface PersonInfoTableViewController () <UITextFieldDelegate, PersonInfoPickerDelegate> {
    

    __weak IBOutlet UITextField *_tfNickname;
    __weak IBOutlet UIDatePicker *_datePicker;
    __weak IBOutlet UIButton *_btnSave;
    __weak IBOutlet UIView *_vwInputAccassory;
    __weak IBOutlet PersonInfoPickerProtocal *_proPIPicker;
    __weak IBOutlet UIPickerView *_pvArea;
    __weak IBOutlet UIView *_vwFemale;
    __weak IBOutlet UIView *_vwMale;
    __weak IBOutlet UITextField *_tfAddress;
    __weak IBOutlet UITextField *_tfProvince;
    __weak IBOutlet UITextField *_tfDistribute;
    __weak IBOutlet UITextField *_tfCity;
    __weak IBOutlet UITextField *_tfUnit;
    __weak IBOutlet UITextField *_tfDaties;
    __weak IBOutlet UITextField *_tfOccupation;
    __weak IBOutlet UITextField *_qualifications;
    __weak IBOutlet UITextField *_tfTel;
    __weak IBOutlet UIImageView *_imgFemale;
    __weak IBOutlet UIButton *_btnFemale;
    __weak IBOutlet UIImageView *_imgMale;
    __weak IBOutlet UIButton *_btnMale;
    __weak IBOutlet UITextField *_tfBirth;
    __weak IBOutlet UITextField *_tfIdentifier;
    __weak IBOutlet UITextField *_tfMobile;
    __weak IBOutlet UITextField *_tfReal;
    
    NSDateFormatter *_format;
    
    double _lng;
    double _lat;
    
    Person *_person;
}

@end

@implementation PersonInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _proPIPicker.delegate = self;
    [self obtainPersonInfo];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Http server

- (void)obtainPersonInfo {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] obtainInfoWithHandler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            _person = [Person mj_objectWithKeyValues:response];
            [self updateUI];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

- (void)savePersonInfoWithInfos:(NSMutableDictionary *)parameters {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] savePersonInfoWithParameters:parameters handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessageOnMainView:@"用户资料保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

- (void)obtainLocationWithAddress:(NSString *)address {
    NSString *url = [NSString stringWithFormat:@"http://apis.map.qq.com/ws/geocoder/v1/?address=%@&key=O3RBZ-VNLHP-A6QDU-V67VA-OTEK7-3XBUP", address];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        } else {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSInteger status = [result[@"status"] integerValue];
            if (status == 0) {
                NSDictionary *locations = result[@"result"][@"location"];
                _lng = [locations[@"lng"] doubleValue];
                _lat = [locations[@"lat"] doubleValue];
            }
        }
    }];
    [task resume];
}
#pragma mark - Action

- (IBAction)actionForDateChanged:(UIDatePicker *)sender {
    _tfBirth.text = [_format stringFromDate:sender.date];
}

- (IBAction)actionForSave:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self checkInfo]) {
        
        NSString *sex = nil;
        if (_btnMale.selected) {
            sex = @"男";
        } else if (_btnFemale.selected) {
            sex = @"女";
        }
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"Nickname"] = _tfNickname.text;
        parameters[@"FullName"] = _tfReal.text;
        parameters[@"Sex"] = sex;
        parameters[@"IdcardNumber"] = _tfIdentifier.text;
        parameters[@"UserJob"] = _tfOccupation.text;
        parameters[@"ResidenceAddressProvince"] = _tfProvince.text;
        parameters[@"ResidenceAddressCity"] = _tfCity.text;
        parameters[@"ResidenceAddressDistrict"] = _tfDistribute.text;
        parameters[@"ResidenceAddressDetail"] = _tfAddress.text;
        parameters[@"Birthday"] = _tfBirth.text;
        parameters[@"UserDuties"] = _tfDaties.text;
        parameters[@"WorkUnit"] = _tfUnit.text;
        parameters[@"AcademicQualification"] = _qualifications.text;
        parameters[@"DefaultAddressLatitude"] = [NSString stringWithFormat:@"%f", _lat];
        parameters[@"DefaultAddressLongitude"] = [NSString stringWithFormat:@"%f", _lng];
        [self savePersonInfoWithInfos:parameters];
    }
    
}

- (IBAction)actionForSure:(UIButton *)sender {
    [self.view endEditing:YES];
    switch (_proPIPicker.level) {
        case PersonAreaLevelProvince:
            [_tfCity becomeFirstResponder];
            break;
        case PersonAreaLevelCity:
            [_tfDistribute becomeFirstResponder];
            break;
        case PersonAreaLevelDistribute:
            break;
        default:
            break;
    }
}

- (IBAction)actionForCancel:(UIButton *)sender {
    [self.view endEditing:YES];
    switch (_proPIPicker.level) {
        case PersonAreaLevelProvince:
            [self chooseCityInProvince:_tfProvince.text];
            break;
        case PersonAreaLevelCity:
            [self chooseDistributeInCity:_tfCity.text];
            break;
        case PersonAreaLevelDistribute:
            break;
        default:
            break;
    }
}

- (IBAction)actionForChooseFemale:(UIButton *)sender {
    sender.selected = YES;
    [self chooseSexIsMale:NO];
}

- (IBAction)actionForChooseMale:(UIButton *)sender {
    sender.selected = YES;
    [self chooseSexIsMale:YES];
}

#pragma mark - Table view delegate 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    } else {
        return 10;
    }
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _tfProvince) {
        [self chooseProvince];
    } else if (textField == _tfCity) {
        [self chooseCityInProvince:_tfProvince.text];
    } else if (textField == _tfDistribute) {
        [self chooseDistributeInCity:_tfCity.text];
    } else if (textField == _tfBirth) {
        [self chooseBirth];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _tfIdentifier) {
        if (textField.text.length - range.length + string.length > 18) {
            return NO;
        } else {
            if (textField.text.length < 17) {
                return [CheckStringManager checkString:string inputExpressions:@"[0-9]"];
            } else {
                return [CheckStringManager checkString:string inputExpressions:@"[0-9X]"];
            }
            
        }
    } else if (textField == _tfTel) {
        if (textField.text.length - range.length + string.length > 12) {
            return NO;
        } else {
            return [CheckStringManager checkString:string inputExpressions:@"[0-9-]"];
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _tfIdentifier) {
        if ([CheckStringManager checkBlankString:_tfBirth.text]) {
            NSString *year = [textField.text substringWithRange:NSMakeRange(6, 4)];
            NSString *month = [textField.text substringWithRange:NSMakeRange(10, 2)];
            NSString *day = [textField.text substringWithRange:NSMakeRange(12, 2)];
            _tfBirth.text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
        }
        if (_btnMale.selected == NO && _btnFemale.selected == NO) {
            
            [self chooseSexIsMale:[[textField.text substringWithRange:NSMakeRange(16, 1)] integerValue] % 2];
        }
    } else if (textField == _tfAddress) {
        NSString *address = [NSString stringWithFormat:@"%@%@%@%@", _tfProvince.text, _tfCity.text, _tfDistribute.text, _tfAddress.text];
        [self obtainLocationWithAddress:address];
    }
}

#pragma mark - Person Info Picker Delegate

- (void)selectRowForTitle:(NSString *)title {
    switch (_proPIPicker.level) {
        case PersonAreaLevelProvince:
        {
            _tfProvince.text = title;
        }
            break;
        case PersonAreaLevelCity:
        {
            _tfCity.text = title;
        }
            break;
        case PersonAreaLevelDistribute:
        {
            _tfDistribute.text = title;
        }
            break;
        default:
            break;
    }
}

#pragma mark - UI

- (void)configUI {
    _proPIPicker.level = PersonAreaLevelDistribute;
    _tfMobile.text = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAccount];
    _format = [[NSDateFormatter alloc] init];
    [_format setDateFormat:@"yyyy-MM-dd"];
    _datePicker.maximumDate = [NSDate date];
    UIImageView *rightView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_view"]];
    rightView1.frame = CGRectMake(0, 0, 15, 10);
    rightView1.contentMode = UIViewContentModeCenter;
    _tfProvince.rightView = rightView1;
    _tfProvince.rightViewMode = UITextFieldViewModeAlways;
    UIImageView *rightView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_view"]];
    rightView2.frame = CGRectMake(0, 0, 15, 10);
    rightView2.contentMode = UIViewContentModeCenter;
    _tfCity.rightView = rightView2;
    _tfCity.rightViewMode = UITextFieldViewModeAlways;
    UIImageView *rightView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_view"]];
    rightView3.frame = CGRectMake(0, 0, 15, 10);
    rightView3.contentMode = UIViewContentModeCenter;
    _tfDistribute.rightView = rightView3;
    _tfDistribute.rightViewMode = UITextFieldViewModeAlways;
}

- (void)updateUI {
    if ([_person.sex isEqualToString:@"男"]) {
        [self chooseSexIsMale:YES];
    } else if ([_person.sex isEqualToString:@"女"]) {
        [self chooseSexIsMale:NO];
    }
    _tfReal.text = _person.realName;
//    _tfMobile.text = _person.mobile;
    _tfIdentifier.text = _person.identity;
    if (![CheckStringManager checkBlankString:_person.birth]) {
        
        NSString *strig = [_person.birth substringToIndex:10];
        NSDate *birthday = [_format dateFromString:strig];
        NSString *birth = [_format stringFromDate:birthday];
        _tfBirth.text = birth;
        
    }
    _tfNickname.text = _person.nickname;
    _tfTel.text = _person.tel;
    _tfOccupation.text = _person.occupation;
    _tfUnit.text = _person.unit;
    _qualifications.text = _person.qualification;
    _tfDaties.text = _person.duties;
    _tfProvince.text = _person.province;
    _tfCity.text = _person.town;
    _tfDistribute.text = _person.district;
    _tfAddress.text = _person.detail;
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws obtainPersonInfo];
    }];
}

- (void)chooseSexIsMale:(BOOL)isMale {
    _btnMale.selected = isMale;
    _imgMale.image = isMale ? [UIImage imageNamed:@"accept_protocol"] : [UIImage imageNamed:@"disaccept_protocol"];
    _btnFemale.selected = !isMale;
    _imgFemale.image = !isMale ? [UIImage imageNamed:@"accept_protocol"] : [UIImage imageNamed:@"disaccept_protocol"];
}

- (void)chooseProvince {
    
    NSArray *provinces = [self obtainProvinces];
    _proPIPicker.sources = provinces;
    _proPIPicker.level = PersonAreaLevelProvince;
    [_pvArea reloadAllComponents];
    _tfProvince.inputView = _pvArea;
    _tfProvince.inputAccessoryView = _vwInputAccassory;
    if ([CheckStringManager checkBlankString:_tfProvince.text] || [_tfProvince.text isEqualToString:@"省选择"]) {
        [_pvArea selectRow:0 inComponent:0 animated:NO];
        [self selectRowForTitle:provinces[0]];
    } else {
        NSInteger index = [provinces indexOfObject:_tfProvince.text];
        [_pvArea selectRow:index inComponent:0 animated:NO];
    }
    
}

- (void)chooseCityInProvince:(NSString *)province {
    _tfCity.inputView = _pvArea;
    _tfCity.inputAccessoryView = _vwInputAccassory;
    if ([CheckStringManager checkBlankString:_tfProvince.text] || [province isEqualToString:@"省选择"]) {
        [_tfCity resignFirstResponder];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self textFieldShouldBeginEditing:_tfProvince];
            
            [_tfProvince becomeFirstResponder];
        });
    } else {
        NSArray *citys = [self obtainCitysByProvince:province];
        _proPIPicker.sources = citys;
        _proPIPicker.level = PersonAreaLevelCity;
        [_pvArea reloadAllComponents];
        
        if ([citys containsObject:_tfCity.text]) {
            NSInteger index = [citys indexOfObject:_tfCity.text];
            [_pvArea selectRow:index inComponent:0 animated:NO];
        } else {
            [_pvArea selectRow:0 inComponent:0 animated:NO];
            [self selectRowForTitle:citys[0]];
        }
    }
}

- (void)chooseDistributeInCity:(NSString *)city {
    _tfDistribute.inputView = _pvArea;
    _tfDistribute.inputAccessoryView = _vwInputAccassory;
    if ([CheckStringManager checkBlankString:_tfCity.text] || [city isEqualToString:@"市选择"]) {
        [_tfDistribute resignFirstResponder];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self textFieldShouldBeginEditing:_tfCity];
            
            [_tfCity becomeFirstResponder];
        });
    } else {
        NSArray *distributes = [self obtainDistributesByCity:city];
        _proPIPicker.sources = distributes;
        _proPIPicker.level = PersonAreaLevelDistribute;
        [_pvArea reloadAllComponents];
        
        if ([distributes containsObject:_tfDistribute.text]) {
            NSInteger index = [distributes indexOfObject:_tfDistribute.text];
            [_pvArea selectRow:index inComponent:0 animated:NO];
        } else {
            [_pvArea selectRow:0 inComponent:0 animated:NO];
            NSString *distribute = distributes[0];
            [self selectRowForTitle:distribute];
        }
    }
}

- (void)chooseBirth {
    if (![CheckStringManager checkBlankString:_tfBirth.text]) {
        _datePicker.date = [_format dateFromString:_tfBirth.text];
    } else {
        _datePicker.date = [NSDate date];
        _tfBirth.text = [_format stringFromDate:[NSDate date]];
    }
    _tfBirth.inputView = _datePicker;
    _tfBirth.inputAccessoryView = _vwInputAccassory;
}

#pragma mark - Method

- (BOOL)checkInfo {
    if (![CheckStringManager checkBlankString:_tfIdentifier.text]) {
        if (![CheckStringManager verifyIDCardNumber:_tfIdentifier.text]) {
            UIAlertController *ac = [AlertManager infoDeficiencyAlert:@"身份证格式不正确，请检查后重新输入"];
            [self presentViewController:ac animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}
@end
