//
//  AppointmentTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/25.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentTableViewController.h"

#import "PayTableViewController.h"
#import "HealthyArchiveDetailTableViewController.h"

#import "AppointmentArchiveTableViewCell.h"

#import "ExpertAppointmentTime.h"

#import "ArchiveClient.h"
#import "ExpertClient.h"

#import "MBPrograssManager.h"
#import <MJExtension.h>
@interface AppointmentTableViewController () <AppoinmentArchiveCellDelegate, UITextFieldDelegate, UITextViewDelegate> {
    
    __weak IBOutlet UIView *_inputAccessoryView;
    __weak IBOutlet UIDatePicker *_inputView;
    __weak IBOutlet UITableView *_tvArchive;
    __weak IBOutlet UITextField *_tfBirth;
    __weak IBOutlet UITextField *_tflReview;
    __weak IBOutlet UIImageView *_imgMale;
    __weak IBOutlet UIButton *_btnMale;
    __weak IBOutlet UIImageView *_imgFemale;
    __weak IBOutlet UIButton *_btnFemale;
    __weak IBOutlet UITextView *_txtInfo;
    __weak IBOutlet UIButton *_btnAppointment;
    
    NSMutableArray *_chooseArchives;
    NSArray *_archives;
    NSMutableArray *_reviewDates;
    NSMutableArray *_reviewTimes;
    
    BOOL _isReview;
    BOOL _canReview;
    
    NSString *_birth;
    NSString *_review;
    
    NSDate *_replyDate;
    NSDate *_birthday;
}

@end

@implementation AppointmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getReviewDate];
    [self getArchives];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)getArchives {
    [[ArchiveClient shareInstance] obtainArchiveListForUser:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId] pageNumber:@"1" limit:@"" from:@"" to:@"" handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            _archives = [HealthyArchive mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            [_tvArchive reloadData];
        } else {
            
        }
    }];
}

- (void)getReviewDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [[ExpertClient shartInstance] getReviewDatesForExpert:_expert.expertId minDate:[formatter stringFromDate:[NSDate date]] handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *appointTimes = [ExpertAppointmentTime mj_objectArrayWithKeyValuesArray:response];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            [appointTimes enumerateObjectsUsingBlock:^(ExpertAppointmentTime *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *time = [obj.time substringToIndex:10];
                NSString *current = [formatter stringFromDate:[NSDate date]];
                if ([time compare:current] != NSOrderedAscending) {
//                if ([time compare:@"2017-08-18"] != NSOrderedAscending) {
                    if (!obj.isFull) {
                        if (_reviewTimes == nil) {
                            _reviewTimes = [NSMutableArray array];
                        }
                        if (_reviewDates == nil) {
                            _reviewDates = [NSMutableArray array];
                        }
                        [_reviewDates addObject:obj];
                        [_reviewTimes addObject:time];
                    }
                }
            }];
        } else {
            
        }
    }];
}

- (void)appointmentExpert {
//    [MBPrograssManager showPrograssOnMainView];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *birth = [[formatter stringFromDate:_birthday] stringByAppendingString:@" 00:00:00"];
//    NSString *reply = [[formatter stringFromDate:_replyDate] stringByAppendingString:@" 00:00:00"];
//    NSMutableString *archiveIds = nil;
//    if (_chooseArchives != nil && _chooseArchives.count != 0) {
//        archiveIds = [NSMutableString string];
//        for (int i = 0; i < _chooseArchives.count; i ++) {
//            HealthyArchive *archive = _chooseArchives[i];
//            [archiveIds appendFormat:@"%@;", archive.archiveCode];
//        }
//    }
//    if (archiveIds != nil) {
//        [archiveIds deleteCharactersInRange:NSMakeRange(archiveIds.length - 1, 1)];
//    }
//    NSString *sex = _btnMale.selected ? @"男" : @"女";
//    [[ExpertClient shartInstance] appointmentExpert:self.expert.expertId forUser:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId] archives:archiveIds birth:birth replyTime:reply sex:sex remark:_txtInfo.text handler:^(id response, BOOL isSuccess) {
//        [MBPrograssManager hidePrograssFromMainView];
//        if (isSuccess) {
//            PayTableViewController *tvcPay = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcPay"];
//            tvcPay.expert = self.expert;
//            tvcPay.archives = _chooseArchives;
//            tvcPay.birth = _birth;
//            tvcPay.reply = _review;
//            tvcPay.remark = _txtInfo.text;
////            tvcPay.orderId = response[@"Id"];
//            tvcPay.sex = sex;
//            [self.navigationController pushViewController:tvcPay animated:YES];
//            
//        } else {
//            [MBPrograssManager showMessage:response OnView:self.view];
//        }
//    }];
}

#pragma mark - Action

- (IBAction)actionForMale:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = YES;
    [self chooseSexIsMale:YES];
}

- (IBAction)actionForFemale:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = YES;
    [self chooseSexIsMale:NO];
}

- (IBAction)actionForAppointmentButton:(UIButton *)sender {
    [self.view endEditing:YES];
//    [self appointmentExpert];
    PayTableViewController *tvcPay = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcPay"];
    tvcPay.expert = self.expert;
    tvcPay.archives = _chooseArchives;
    tvcPay.birth = _birth;
    tvcPay.reply = _review;
    tvcPay.remark = _txtInfo.text;
    //            tvcPay.orderId = response[@"Id"];
    NSString *sex = _btnMale.selected ? @"男" : @"女";
    tvcPay.sex = sex;
    NSMutableString *archiveIds = nil;
    if (_chooseArchives != nil && _chooseArchives.count != 0) {
        archiveIds = [NSMutableString string];
        for (int i = 0; i < _chooseArchives.count; i ++) {
            HealthyArchive *archive = _chooseArchives[i];
            [archiveIds appendFormat:@"%@;", archive.archiveCode];
        }
    }
    if (archiveIds != nil) {
        [archiveIds deleteCharactersInRange:NSMakeRange(archiveIds.length - 1, 1)];
    }
    tvcPay.archiveIds = archiveIds;
    [self.navigationController pushViewController:tvcPay animated:YES];
}

- (IBAction)actionForBirthButton:(UIButton *)sender {
    [self.view endEditing:YES];
    [_tfBirth becomeFirstResponder];
}

- (IBAction)actionForReviewTimeButton:(UIButton *)sender {
    [self.view endEditing:YES];
    [_tflReview becomeFirstResponder];
}

- (IBAction)actionForSureButton:(UIButton *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [formatter stringFromDate:_inputView.date];
    if (_isReview) {
        if (_canReview) {
            [MBPrograssManager showMessage:@"该日期预约已满，请重新选择" OnView:self.view];
        } else {
            [self.view endEditing:YES];
            _review = dateString;
            _tflReview.text = _review;
            _replyDate = _inputView.date;
        }
    } else {
        [self.view endEditing:YES];
        _birth = dateString;
        _tfBirth.text = _birth;
        _birthday = _inputView.date;
    }
}

- (IBAction)actionForCancelButton:(UIButton *)sender {
    [self.view endEditing:YES];
}

- (IBAction)actionForInputViewChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *chooseDate = [formatter stringFromDate:sender.date];
    if (_reviewTimes != nil &&_reviewTimes.count != 0) {
        if ([sender respondsToSelector:NSSelectorFromString(@"setHighlightsToday:")]) {
            [sender performSelector:NSSelectorFromString(@"setHighlightsToday:") withObject:@NO];
        }
        if ([_reviewTimes containsObject:chooseDate]) {
            [sender setValue:[UIColor blackColor] forKey:@"textColor"];
        } else {
            [sender setValue:[UIColor grayColor] forKey:@"textColor"];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tvArchive) {
        return 1;
    } else {
        return [super numberOfSectionsInTableView:tableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tvArchive) {
        return _archives.count;
    } else {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tvArchive) {
        static NSString *cellIdentifier = @"AppointmentArchiveCell";
        AppointmentArchiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.archive = _archives[indexPath.row];
        cell.delegate = self;
        [cell loadCell];
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - Text view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tvArchive) {
        return 44;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _tvArchive) {
        return [UIView new];
    } else {
        return [super tableView:tableView viewForHeaderInSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _tvArchive) {
        return 0.0001;
    } else {
        switch (section) {
            case 0:
                return 30;;
                break;
            case 1:
                return 10;
                break;
            case 2:
                return 5;
                break;
            case 3:
                return 10;
                break;
            case 4:
                return 10;
                break;
            default:
                break;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

#pragma mark - Text view delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    self.tableView scro
    return YES;
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.inputView = _inputView;
    textField.inputAccessoryView = _inputAccessoryView;
    if (textField == _tflReview) {
        _inputView.minimumDate = [NSDate date];
        if (_reviewTimes != nil && _reviewTimes.count != 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *minDate = [formatter dateFromString:_reviewTimes[0]];
            _inputView.minimumDate = minDate;
        }
        _isReview = YES;
    } else {
        _inputView.minimumDate = [NSDate date];
        _isReview = NO;
    }
    return YES;
}

#pragma mark - Appointment archive cell delegate

- (BOOL)chooseArchive:(HealthyArchive *)archive select:(BOOL)select {
    if (_chooseArchives == nil) {
        _chooseArchives = [NSMutableArray array];
    }
    if (select) {
        if (_chooseArchives.count >= 3) {
            [MBPrograssManager showMessage:@"最多可选择3条档案" OnView:self.view];
            return NO;
        } else {
            [_chooseArchives addObject:archive];
            return YES;
        }
    } else {
        if ([_chooseArchives containsObject:archive]) {
            [_chooseArchives removeObject:archive];
            return NO;
        }
    }
    return YES;
}

- (void)reviewArchive:(HealthyArchive *)archive {
    HealthyArchiveDetailTableViewController *tvcArchiveDetail = [[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchiveDetail"];
    tvcArchiveDetail.archiveId = archive.archiveId;
    [self.navigationController pushViewController:tvcArchiveDetail animated:YES];
}

#pragma mark - Method

- (void)chooseSexIsMale:(BOOL)isMale {
    _btnMale.selected = isMale;
    _imgMale.image = isMale ? [UIImage imageNamed:@"accept_protocol"] : [UIImage imageNamed:@"disaccept_protocol"];
    _btnFemale.selected = !isMale;
    _imgFemale.image = !isMale ? [UIImage imageNamed:@"accept_protocol"] : [UIImage imageNamed:@"disaccept_protocol"];
}

@end
