//
//  AddMedicationsViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AddMedicationsViewController.h"

#import "MedicationDetailTableViewController.h"
#import "MedicationsTableViewController.h"

#import "AddMedicationTableViewCell.h"
#import "HDDateView.h"

#import "MedicaitonClient.h"

#import "MBPrograssManager.h"
#import <MJExtension.h>
@interface AddMedicationsViewController () <UITableViewDelegate, UITableViewDataSource, AddMedicationCellDelegate, HDDateViewDelegate, MedicationsDelegate> {
    
    __weak IBOutlet HDDateView *_vwFrom;
    __weak IBOutlet HDDateView *_vwTo;
    __weak IBOutlet UITableView *_tvAddMedications;
    __weak IBOutlet UITextView *_txtInfo;
    __weak IBOutlet UILabel *_lblInfoCount;
    
    NSDate *_from;
    NSDate *_to;
}

@end

@implementation AddMedicationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
//    [self configAddMeications];
}

- (void)viewWillAppear:(BOOL)animated {
    _tvAddMedications.tableFooterView.hidden = self.medications == nil || self.medications.count == 0;
}

//- (void)setMedications:(NSMutableArray *)medications {
//    _medications = medications;
//    _tvAddMedications.tableFooterView.hidden = medications == nil || medications.count == 0;
//    [_tvAddMedications reloadData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)addMedicationRecord {
    [MBPrograssManager showPrograssOnMainView];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *from = [[formatter stringFromDate:_from] stringByAppendingString:@" 00:00:00"];
    NSString *to = [[formatter stringFromDate:_to] stringByAppendingString:@" 00:00:00"];
    NSMutableArray *medications = [AddMedication mj_keyValuesArrayWithObjectArray:_addMedications];
    for (int i = 0; i < medications.count; i ++) {
        AddMedication *addMedicaiton = _addMedications[i];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:medications[i]];
        [dict removeObjectForKey:@"medication"];
        dict[@"IsEvening"] = addMedicaiton.isEvening ? @"true" : @"false";
        dict[@"IsMorning"] = addMedicaiton.isMorning ? @"true" : @"false";
        dict[@"IsNooning"] = addMedicaiton.isAfternoon ? @"true" : @"false";
        [medications replaceObjectAtIndex:i withObject:dict];
    }
    [[MedicaitonClient shareInstance] addMedicationRecord:self.recordId user:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId] from:from to:to remark:_txtInfo.text medications:medications handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessageOnMainView:@"添加服药记录成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRefreshMedicationRecords object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForSubmitButton:(UIBarButtonItem *)sender {
    if ([self checkInfo]) {
        [self addMedicationRecord];
    }
}

- (IBAction)actionForAddButton:(UIButton *)sender {
    MedicationsTableViewController *tvcMedications = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcMedicaitons"];
    tvcMedications.delegate = (id)self;
    [self.navigationController pushViewController:tvcMedications animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addMedications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"AddMedicationCell";
    AddMedicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.medication = _addMedications[indexPath.row];
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 238;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

#pragma mark - Add medication cell delegate
//
//- (void)medication:(AddMedication *)medication inInterval:(MedicationInteval)inteval dosage:(NSString *)dosage selecte:(BOOL)isSelect {
//    switch (inteval) {
//        case medicaitonAtMorning:
//            medication.morning.isMedication = isSelect;
//            medication.morning.desoge = dosage;
//            break;
//        case medicationAtAfternoon:
//            medication.afternoon.isMedication = isSelect;
//            medication.afternoon.desoge = dosage;
//            break;
//        case medicationAtEvening:
//            medication.evening.isMedication = isSelect;
//            medication.evening.desoge = dosage;
//            break;
//        default:
//            break;
//    }
//}

- (void)deleteMedication:(AddMedication *)medication {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"确认删除药品" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_addMedications removeObject:medication];
        [_tvAddMedications reloadData];
    }];
    [ac addAction:cancel];
    [ac addAction:sure];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)reviewMedication:(AddMedication *)medication {
    MedicationDetailTableViewController *tvcMedicationDetail = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcMedicationDetail"];
    tvcMedicationDetail.medication = medication.medication;
    [self.navigationController pushViewController:tvcMedicationDetail animated:YES];
}

#pragma mark - Date view delegate

- (void)chooseDate:(NSDate *)date type:(HDDateViewType)type {
    switch (type) {
        case dateViewForm:
            _from = date;
            break;
        case dateViewTo:
            _to = date;
            break;
        default:
            break;
    }
}

#pragma mark - Medication delegate

- (void)saveMeidcations:(NSArray *)medications {
    if (self.medications == nil) {
        self.medications = [NSMutableArray array];
    }
    [medications enumerateObjectsUsingBlock:^(Medication *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self.medications containsObject:obj]) {
            [self.medications addObject:obj];
        }
        if (idx == medications.count - 1) {
            [self configAddMeications];
        }
    }];
    if (_tvAddMedications.tableFooterView.isHidden) {
        _tvAddMedications.tableFooterView.hidden = NO;
    }
}

#pragma mark - Setter 

//- (void)setFrom:(NSDate *)from {
//    _from = from;
//    _vwFrom.inputDate = from;
//}
//
//- (void)setTo:(NSDate *)to {
//    _to = to;
//    _vwTo.inputDate = to;
//}

#pragma mark - UI

- (void)configView {
    _vwFrom.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"自%@", dateString];
    };
    _vwFrom.type = dateViewForm;
    _vwFrom.delegate = (id)self;
    _vwFrom.inputDate = _from;
    _vwTo.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"至%@", dateString];
    };
    _vwTo.type = dateViewTo;
    _vwTo.delegate = (id)self;
    _vwTo.inputDate = _to;
}

#pragma mark - Method

- (void)configAddMeications {
    
    if (_addMedications == nil) {
        _addMedications = [NSMutableArray array];
    }
    
    [self.medications enumerateObjectsUsingBlock:^(Medication *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AddMedication *add = [[AddMedication alloc] init];
        add.medication = obj;
        add.medicationId = obj.medicationId;
        [_addMedications addObject:add];
        if (idx == self.medications.count - 1) {
            [_tvAddMedications reloadData];
        }
    }];
}

- (BOOL)checkInfo {
    if (self.medications.count == 0 || self.medications == nil) {
        [MBPrograssManager showMessage:@"请选择药品" OnView:self.view];
        return NO;
    }
    if (_from == nil) {
        [MBPrograssManager showMessage:@"请选择服药起始日期" OnView:self.view];
        return NO;
    }
    if (_to == nil) {
        [MBPrograssManager showMessage:@"请选择结束日期" OnView:self.view];
        return NO;
    }
    for (int i = 0; i < _addMedications.count; i ++) {
        AddMedication *addMedication = _addMedications[i];
        if (addMedication.isMorning == NO && addMedication.isAfternoon == NO && addMedication.isEvening == NO) {
            NSString *message = [NSString stringWithFormat:@"请填写%@的服药剂量", addMedication.medication.goodsName];
            [MBPrograssManager showMessage:message OnView:self.view];
            return NO;
        }
    }
    return YES;
}

@end
