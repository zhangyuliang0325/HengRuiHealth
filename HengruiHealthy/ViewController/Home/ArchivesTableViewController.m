//
//  ArchivesTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/28.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivesTableViewController.h"

#import "ArchivesTableViewCell.h"
#import "RountineUrineInfo.h"
#import "BloodFatInfo.h"
#import "ElectrocardioInfo.h"
#import "BlankPage.h"
#import "ArchivesRightItem.h"

#import "ArchivesService.h"
#import "HomeClient.h"

#import "MBPrograssManager.h"
#import <MJRefresh/MJRefresh.h>

NSString *const ROUTINEURINEURL =@"QueryURDataV1";
NSString *const BLOODFATURL = @"QueryBD_FATDataV1";
NSString *const ELECTROCARDIOURL = @"QueryEcgStructV1";

@interface ArchivesTableViewController () <UITextFieldDelegate, BlankPageDelegate> {
    __weak IBOutlet UIButton *_btnQuery;
    __weak IBOutlet UIView *_is;
    __weak IBOutlet UIDatePicker *_dp;
    __weak IBOutlet UILabel *_lblEnd;
    __weak IBOutlet UILabel *_lblStart;
    __weak IBOutlet UITextField *_tfStart;
    __weak IBOutlet UITextField *_tfEnd;
   __weak IBOutlet UIView *_vwHeader;
    NSInteger _pageNumber;
    NSInteger _limitCount;
    NSMutableArray *_archives;
    NSInteger _type;
    NSDate *_startDate;
    NSDate *_endDate;
    UIView *_emptyPage;
    BlankPage *_blank;
}

@end

@implementation ArchivesTableViewController

- (void)dealloc {
    self.navigationItem.rightBarButtonItems = nil;
    NSLog(@"archives %@ dealloc", _fileName);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initComponents];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)obtainArchivesForFile:(NSString *)file start:(NSString *)startDate end:(NSString *)endDate limit:(NSInteger)limitCount page:(NSInteger)pageNumber {
    [[HomeClient shareInstance] obtainArchivesForFile:file fromDate:startDate toDate:endDate sort:DESC pageIndex:pageNumber handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *items = [ArchivesService repleaceDicArray:response[@"Items"] toModelArray:self.fileName];
            [_archives addObjectsFromArray:items];
            [self endRefresh];
            [self.tableView reloadData];
        } else {
            _pageNumber --;
            [MBPrograssManager showMessage:response OnView:self.tableView];
            if (self.tableView.mj_header.isRefreshing) {
                [self.tableView.mj_header endRefreshing];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForSure:(UIButton *)sender {
    [self.view endEditing:YES];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSDate *from;
    NSDate *to;
    switch (_type) {
        case 0:
        {
            from = _dp.date;
            to = _endDate;
        }
            break;
        case 1:
        {
            to = _dp.date;
            from = _startDate;
        }
            break;
        default:
            break;
    }
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if ([from compare:to] != 1) {
        _startDate = from;
        _endDate = to;
        [self.tableView.mj_header beginRefreshing];
    } else {
        [MBPrograssManager showMessageOnMainView:@"日期选择错误，起始日期大于结束日期"];
    }
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    _lblStart.text = [@"自" stringByAppendingString:[formatter stringFromDate:from]];
    _lblEnd.text = [@"至" stringByAppendingString:[formatter stringFromDate:to]];
}

- (IBAction)actionForCancel:(UIButton *)sender {
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _archives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ArchivesTableViewCell";
    ArchivesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.t = _archives[indexPath.row];
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 88;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _vwHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.fileName isEqualToString:ROUTINEURINEURL]) {
        RountineUrineInfo *vwRountineUrine = [[[NSBundle mainBundle] loadNibNamed:@"RountineUrineInfo" owner:self options:nil] lastObject];
        RoutineUrine *rountineUrine = (RoutineUrine *)_archives[indexPath.row];
        vwRountineUrine.rountinUrine = rountineUrine;
        vwRountineUrine.frame = CGRectMake(0, 0, HRHtyScreenWidth, HRHtyScreenHeight);
        [vwRountineUrine configInfo];
        [[UIApplication sharedApplication].keyWindow addSubview:vwRountineUrine];
    } else if ([self.fileName isEqualToString:BLOODFATURL]) {
        BloodFatInfo *vwBloodFatInfo = [[[NSBundle mainBundle] loadNibNamed:@"BloodFatInfo" owner:self options:nil] lastObject];
        BloodFat *fat = (BloodFat *)_archives[indexPath.row];
        vwBloodFatInfo.fat = fat;
        vwBloodFatInfo.frame = CGRectMake(0, 0, HRHtyScreenWidth, HRHtyScreenHeight);
        [vwBloodFatInfo configInfo];
        [[UIApplication sharedApplication].keyWindow addSubview:vwBloodFatInfo];

    } else {
        Electrocardio *electrocardio = _archives[indexPath.row];
        ElectrocardioInfo *vwElectrocardio = [[[NSBundle mainBundle] loadNibNamed:@"ElectrocardioInfo" owner:self options:nil] lastObject];
        vwElectrocardio.frame = CGRectMake(0, 0, HRHtyScreenWidth, HRHtyScreenHeight);
        vwElectrocardio.electrocardio = electrocardio;
        [vwElectrocardio configView];
        [[UIApplication sharedApplication].keyWindow addSubview:vwElectrocardio];
    }
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年MM月dd日"];
    if (textField == _tfStart) {
        _type = 0;
        
        if (_tfStart.text.length != 0) {
            NSDate *date = [formater dateFromString:[_lblStart.text substringFromIndex:1]];
            _dp.date = date;
        }
    } else {
        _type = 1;
        if (_lblEnd.text.length != 0) {
            NSDate *date = [formater dateFromString:[_lblEnd.text substringFromIndex:1]];
            _dp.date = date;
        }
    }
    textField.inputView = _dp;
    textField.inputAccessoryView = _is;
    return YES;
}

#pragma mark - Blank page delegate

- (void)retry {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UI

- (void)initView {
    [self addRightItem];
    if ([self.fileName isEqualToString:ROUTINEURINEURL]) {
        self.navigationItem.title = @"尿常规档案";
    } else if ([self.fileName isEqualToString:BLOODFATURL]) {
        self.navigationItem.title = @"血脂档案";
    } else {
        self.navigationItem.title = @"心电档案";
    }
    [self initDatePicker];
    [self addRefreshHeader];
    [self addRefreshFooter];
    [self setDateText];
    [self initBlankPage];
    [self.tableView.mj_header beginRefreshing];
}

- (void)initBlankPage {
    _blank = [[[NSBundle mainBundle] loadNibNamed:@"BlankPage" owner:self options:nil] lastObject];
    _blank.frame = CGRectMake(0, 0, HRHtyScreenWidth, HRHtyScreenHeight - 154);
    _blank.delegate = (id)self;
}

- (void)initDatePicker {
    _dp.maximumDate = [NSDate date];
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        [ss->_archives removeAllObjects];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *from = @"";
        NSString *to = @"";
        if (ss->_startDate != nil) {
            from = [[formatter stringFromDate:ss->_startDate] stringByAppendingString:@" 00:00:00"];
        }
        if (ss->_endDate != nil) {
            to = [[formatter stringFromDate:ss->_endDate] stringByAppendingString:@" 23:59:59"];
        }
        ss->_pageNumber = 1;
        [ws obtainArchivesForFile:ss->_fileName start:from end:to limit:ss->_limitCount page:ss->_pageNumber];
    }];
}

- (void)addRefreshFooter {
    __weak typeof(self) ws = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_pageNumber ++;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *from = @"";
        NSString *to = @"";
        if (ss->_startDate != nil) {
            from = [[formatter stringFromDate:ss->_startDate] stringByAppendingString:@" 00:00:00"];
        }
        if (ss->_endDate != nil) {
            to = [[formatter stringFromDate:ss->_endDate] stringByAppendingString:@" 23:59:59"];
        }

        [ws obtainArchivesForFile:ss->_fileName start:from end:to limit:ss->_limitCount page:ss->_pageNumber];
    }];
}

- (void)endRefresh {
    [self hideBlankPage];
    int realCount = (int)_archives.count;
    int totalCount = (int)_pageNumber * (int)_limitCount;
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
        if (realCount == 0) {
            [self showBlankPage];
        } else if (realCount < totalCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } else {
        if (realCount < totalCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

- (void)setDateText {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    _lblEnd.text = [@"至" stringByAppendingString:[formatter stringFromDate:_endDate]];
    _lblStart.text = [@"自" stringByAppendingString:[formatter stringFromDate:_startDate]];
}

#pragma mark - Method

- (void)initComponents {
    _limitCount = 15;
    _archives = [[NSMutableArray alloc] init];
    [self initDate];
    
}

- (void)initDate {
    _endDate = [NSDate date];
    _startDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitWeekOfMonth value:-1 toDate:_endDate options:NSCalendarSearchBackwards];
}

- (void)showBlankPage {
    self.tableView.tableFooterView = _blank;
    self.tableView.mj_footer.hidden = YES;
}

- (void)hideBlankPage {
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.mj_footer.hidden = NO;
}

- (void)addRightItem {
    ArchivesRightItem *rightItemView = [[[NSBundle mainBundle] loadNibNamed:@"ArchivesRightItem" owner:self options:nil] lastObject];
    rightItemView.vc = self;
    rightItemView.title = self.title;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
    self.navigationItem.rightBarButtonItem = rightItem;
}

@end
