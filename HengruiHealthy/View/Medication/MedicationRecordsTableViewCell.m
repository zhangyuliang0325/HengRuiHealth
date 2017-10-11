
//
//  MedicationRecordsTableViewCell.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MedicationRecordsTableViewCell.h"

#import "AddMedication.h"

@interface MedicationRecordsTableViewCell () <UITableViewDelegate, UITableViewDataSource> {
    
    __weak IBOutlet UILabel *_lblFrom;
    __weak IBOutlet UILabel *_lblTo;
    __weak IBOutlet UITableView *_tvMedication;
    __weak IBOutlet UIButton *_btnEdit;
    __weak IBOutlet UIButton *_btnDelete;
    __weak IBOutlet UITextView *_txtInfo;
    
    NSArray *_medicationIntervalIconTitles;
}

@end

int const MEDICATIONINTERVALCOUNTTAG = 9001;
int const MEDICATIONINTERVALICONTAG = 9002;
int const MEDICATIONHEADERTAG = 8001;

@implementation MedicationRecordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _tvMedication.delegate = (id)self;
    _tvMedication.dataSource = (id)self;
    _medicationIntervalIconTitles = [NSArray arrayWithObjects:@"早", @"中", @"晚", nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.record.addMedications.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"RecordsMedicationIntervalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UILabel *lblCount = (UILabel *)[cell.contentView viewWithTag:MEDICATIONINTERVALCOUNTTAG];
    UILabel *lblIcon = (UILabel *)[cell.contentView viewWithTag:MEDICATIONINTERVALICONTAG];
    lblIcon.text = _medicationIntervalIconTitles[indexPath.row];
    AddMedication *medication = self.record.addMedications[indexPath.section];
    switch (indexPath.row) {
        case 0:
        {
            lblCount.text = [NSString stringWithFormat:@"服药剂量: %@%@/次", medication.morningCount, medication.unit];
        }
            break;
        case 1:
        {
            lblCount.text = [NSString stringWithFormat:@"服药剂量: %@%@/次", medication.afternoonCount, medication.unit];
        }
            break;
        case 2:
        {
            lblCount.text = [NSString stringWithFormat:@"服药剂量: %@%@/次", medication.eveningCount, medication.unit];
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddMedication *medication = self.record.addMedications[indexPath.section];
    switch (indexPath.row) {
        case 0:
            return medication.isMorning ? 30 : 0;
            break;
        case 1:
            return medication.isAfternoon ? 30 : 0;
            break;
        case 2:
            return medication.isEvening ? 30 : 0;
            break;
        default:
            break;
    };
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *footerIdentifier = @"RecordsMedicationFooter";
    UIView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    if (footer == nil) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HRHtyScreenWidth, 1)];
        footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerIdentifier = @"RecordsMedicationHeader";
    UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (header == nil) {
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HRHtyScreenWidth,44)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *lblHeaderTitle = [[UILabel alloc] init];
        lblHeaderTitle.frame = CGRectMake(15, 0, HRHtyScreenWidth - 15, 44);
        lblHeaderTitle.numberOfLines = 2;
        lblHeaderTitle.font = [UIFont systemFontOfSize:15.0f];
        lblHeaderTitle.tag = MEDICATIONHEADERTAG;
        [header addSubview:lblHeaderTitle];
    }
    AddMedication *medication = self.record.addMedications[section];
    UILabel *lblHeaderTitle = (UILabel *)[header viewWithTag:MEDICATIONHEADERTAG];
    lblHeaderTitle.text = medication.goodsName;
    return header;
}

#pragma mark - Action

- (IBAction)actionForEditButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(editRecord:)]) {
        [self.delegate editRecord:self.record];
    }
}

- (IBAction)actionForDeleteButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteRecord:)]) {
        [self.delegate deleteRecord:self.record];
    }
}

#pragma mark - UI

- (void)loadCell {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *from = [formatter dateFromString:[self.record.from substringToIndex:10]];
    NSDate *to = [formatter dateFromString:[self.record.to substringToIndex:10]];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    _lblFrom.text = [formatter stringFromDate:from];
    _lblTo.text = [formatter stringFromDate:to];
    _txtInfo.text = self.record.remark;
    [_tvMedication reloadData];
}

@end
