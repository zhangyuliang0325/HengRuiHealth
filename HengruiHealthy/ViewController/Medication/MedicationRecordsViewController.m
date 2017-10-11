//
//  MedicationRecordsViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MedicationRecordsViewController.h"

#import "AddMedicationsViewController.h"

#import "HDDateView.h"
#import "MedicationRecordsTableViewCell.h"
#import "BlankHealthyArchiveList.h"


#import "MedicaitonClient.h"

#import <MJRefresh/MJRefresh.h>
#import <MJExtension.h>
@interface MedicationRecordsViewController () <UITableViewDataSource, UITableViewDelegate, BlankHealthyArchiveListDelegate, HDDateViewDelegate, MedicationRecordCellDelegate> {
    
    __weak IBOutlet HDDateView *_vwFrom;
    __weak IBOutlet HDDateView *_vwTo;
    __weak IBOutlet UITableView *_tvRecords;
    __weak IBOutlet UIButton *_btnAdd;
    
    BlankHealthyArchiveList *_blankPage;
    
    NSMutableArray *_records;
    int _page;
    NSString *_from;
    NSString *_to;
}

@end

static int _limit = 15;

@implementation MedicationRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)getRecords {
    [[MedicaitonClient shareInstance] getMedicationRecords:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId] page:[NSString stringWithFormat:@"%d", _page] limit:[NSString stringWithFormat:@"%d", _limit] min:_from max:_to handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *records = [MedicationRecord mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            if (_records == nil) {
                _records = [NSMutableArray array];
            }
            [_records addObjectsFromArray:records];
            [_tvRecords reloadData];
        } else {
            
        }
        [self endRefresh];
    }];
}

#pragma mark - Action

- (IBAction)actionForAddButton:(UIButton *)sender {
    AddMedicationsViewController *vcAddMedicaaitons = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"vcAddMedications"];
    [self.navigationController pushViewController:vcAddMedicaaitons animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MedicationRecordsCell";
    MedicationRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.record = _records[indexPath.row];
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 360;
}

#pragma mark - Blank page delegate

- (void)addArchiveBlank {
    AddMedicationsViewController *vcAddMedicaaitons = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"vcAddMedications"];
    [self.navigationController pushViewController:vcAddMedicaaitons animated:YES];
}

#pragma mark - Date view delegate

- (void)chooseDate:(NSDate *)date type:(HDDateViewType)type {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    switch (type) {
        case dateViewForm:
            _from = [dateString stringByAppendingString:@" 00:00:00"];
            break;
        case dateViewTo:
            _to = [dateString stringByAppendingString:@" 00:00:00"];
            break;
        default:
            break;
    }
    [_tvRecords.mj_header beginRefreshing];
}

#pragma mark - Medication record cell delegate

- (void)deleteRecord:(MedicationRecord *)record {
    
}

- (void)editRecord:(MedicationRecord *)record {
    AddMedicationsViewController *vcAddMedicaaitons = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"vcAddMedications"];
    NSMutableArray *medications = [NSMutableArray array];
    for (int i = 0; i < record.addMedications.count; i ++) {
        AddMedication *addMedication = record.addMedications[i];
        [medications addObject:addMedication.medication];
    }
    vcAddMedicaaitons.addMedications = [NSMutableArray arrayWithArray:record.addMedications];
    vcAddMedicaaitons.medications = medications;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *from = [formatter dateFromString:[record.from substringToIndex:10]];
    NSDate *to = [formatter dateFromString:[record.to substringToIndex:10]];
    vcAddMedicaaitons.from = from;
    vcAddMedicaaitons.to = to;
    vcAddMedicaaitons.recordId = record.recordId;
    [self.navigationController pushViewController:vcAddMedicaaitons animated:YES];
}

#pragma mark - UI

- (void)configUI {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshList) name:kNotificationRefreshMedicationRecords object:nil];
    _vwFrom.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"自%@", dateString];
    };
    _vwFrom.type = dateViewForm;
    _vwFrom.delegate = (id)self;
    _vwTo.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"至%@", dateString];
    };
    _vwTo.type = dateViewTo;
    _vwFrom.delegate = (id)self;
    [self addRefreshFooter];
    [self addRefreshHeader];
    [_tvRecords.mj_header beginRefreshing];
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    _tvRecords.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        [ss->_records removeAllObjects];
        ss->_page = 1;
        [ss getRecords];
    }];
}

- (void)addRefreshFooter {
    __weak typeof(self) ws = self;
    _tvRecords.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_page ++;
        [ss getRecords];
    }];
    _tvRecords.mj_footer.automaticallyHidden = YES;
}

- (void)endRefresh {
    if ([self.view.subviews containsObject:_blankPage]) {
        [_blankPage removeFromSuperview];
    }
    if (_tvRecords.mj_header.isRefreshing) {
        [_tvRecords.mj_header endRefreshing];
        if (_records.count == 0) {
            [self showBlankPage];
        }
    } else {
        if (_page * _limit > _records.count) {
            [_tvRecords.mj_footer endRefreshingWithNoMoreData];
        } else {
            [_tvRecords.mj_footer endRefreshing];
        }
    }
}

- (void)showBlankPage {
    if (_blankPage == nil) {
        _blankPage = [[[NSBundle mainBundle] loadNibNamed:@"BlankHealthyArchiveList" owner:self options:nil] lastObject];
        _blankPage.frame = CGRectMake(0, _tvRecords.frame.origin.y, HRHtyScreenWidth, HRHtyScreenHeight - 114);
        _blankPage.title = @"添加服药记录";
        _blankPage.message = @"您还未添加任何服药记录，快点击下方的按钮添加吧";
        _blankPage.delegate = (id)self;
    }
    [self.view addSubview:_blankPage];
}

#pragma mark - Method

- (void)refreshList {
    _from = nil;
    _to = nil;
    [_vwFrom repleaceView];
    [_vwTo repleaceView];
    _vwFrom.inputDate = _vwTo.inputDate = [NSDate date];
    [_tvRecords.mj_header beginRefreshing];
}

@end
