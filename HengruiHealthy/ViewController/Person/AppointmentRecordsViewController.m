//
//  AppointmentRecordsViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentRecordsViewController.h"

#import "AppointmentDetailTableViewController.h"
#import "ExpertReviewViewController.h"
#import "PayTableViewController.h"

#import "PayTableViewCell.h"
#import "EvalueTableViewCell.h"
#import "ReviewTableViewCell.h"
#import "OverdueTableViewCell.h"
#import "CompletTableViewCell.h"
#import "EvalueExpert.h"

#import "HealthyArchive.h"
#import "EvalueLabel.h"

#import "PersonClient.h"

#import "CheckStringManager.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface AppointmentRecordsViewController () <UITableViewDelegate, UITableViewDataSource, AppointmentCellDelegate, EvalueExpertDelegate> {
    __weak IBOutlet UITableView *_tvRecord;
    __weak IBOutlet UIButton *_btnAll;
    __weak IBOutlet UIButton *_btnPlaying;
    __weak IBOutlet UIButton *_btnPay;
    __weak IBOutlet UIButton *_btnComplete;
    NSMutableArray *_records;
    NSArray *_buttons;
    int _orderState;
    NSMutableArray *_goodsEvalues;
    NSMutableArray *_badEvalues;
    EvalueExpert *_vwEvalue;
    
    CGFloat _evalueCellHeight;
}

@property(nonatomic,retain) NSMutableDictionary *params;   //网络请求参数
@property(nonatomic,assign) int page;                      //请求参数页码

@end

static int all = 0;
static int playing = 1;
static int pay = 2;
static int complete = 3;

@implementation AppointmentRecordsViewController

//lazy懒加载
-(NSMutableDictionary *)params{
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
        _params[@"IdentityUserIdAssign"] = @"Id";
        _params[@"PageIndex"] = @"1";
        _params[@"QueryLimit"] = @"10";
        _params[@"IsEnd"] = nil;
        _params[@"IsPayment"] = nil;
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约记录";
    _buttons = [NSArray arrayWithObjects:_btnAll, _btnPlaying, _btnPay, _btnComplete, nil];
    [self getAppointmentRecordsAtPage];
    [self getEvalueLabels];
    [self setUpRefresh];
    // Do any additional setup after loading the view.
}

//设置刷新与加载
- (void)setUpRefresh{
    _tvRecord.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    _tvRecord.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
}
//下拉刷新
- (void)loadNewDatas{
    self.params[@"PageIndex"] = @"1";
    [self getAppointmentRecordsAtPage];
}
//上拉加载
- (void)loadMoreDatas{
    self.page += 1;
    self.params[@"PageIndex"] = [NSString stringWithFormat:@"%d",self.page];
    [[PersonClient shareInstance] getAppointmentRecords:self.params handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *records = [AppointmentRecord mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            if (records.count == 0) {
                [_tvRecord.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            [_records addObjectsFromArray:records];
            [_tvRecord reloadData];
            [_tvRecord.mj_footer endRefreshing];
        } else {
            
        }
    }];
}

- (void)getAppointmentRecordsAtPage {
    [[PersonClient shareInstance] getAppointmentRecords:self.params handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *records = [AppointmentRecord mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            if (_records == nil) {
                _records = [NSMutableArray array];
            }
            [_records removeAllObjects];
            [_records addObjectsFromArray:records];
            [_tvRecord reloadData];
            [_tvRecord.mj_header endRefreshing];
        } else {
            
        }
    }];
}

- (void)saveRecord:(AppointmentRecord *)record isEnd:(NSString *)isEnd star:(NSString *)star evalue:(NSString *)evalue labels:(NSString *)labels evalueCategory:(NSString *)category {
    NSMutableString *archiveIds = [NSMutableString string];
    for (int i = 0; i < record.reports.count; i ++) {
        HealthyArchive *archive = record.reports[i];
        [archiveIds appendFormat:@"%@;", archive.archiveId];
    }
    if (archiveIds.length == 0) {
        return;
    }
    [archiveIds deleteCharactersInRange:NSMakeRange(archiveIds.length, 1)];
    [[PersonClient shareInstance] saveAppointmentRecord:record.recordId userId:record.userId expertId:record.expertId archiveIds:archiveIds birthday:record.birthday appointmentTime:record.lastReplyTime sex:record.sex remark:record.remark star:star evalueContent:evalue evalueLabel:labels isEnd:isEnd evalueCategory:category handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            [self getAppointmentRecordsAtPage];
        } else {
            
        }
    }];
}

- (void)getEvalueLabels {
    [[PersonClient shareInstance] queryEvalueLabel:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *labels = [EvalueLabel mj_objectArrayWithKeyValuesArray:response];
            for (int i = 0; i < labels.count; i ++) {
                EvalueLabel *label = labels[i];
                if ([label.category isEqualToString:@"好评"]) {
                    if (_goodsEvalues == nil) {
                        _goodsEvalues = [NSMutableArray array];
                    }
                    [_goodsEvalues addObject:label];
                } else {
                    if (_badEvalues == nil) {
                        _badEvalues = [NSMutableArray array];
                    }
                    [_badEvalues addObject:label];
                }
            }
        } else {
            
        }
    }];
}

- (void)doCompleteRecord:(AppointmentRecord *)record  {
    [self saveRecord:record isEnd:@"true" star:[NSString stringWithFormat:@"%d", record.starCount] evalue:record.evalueContent labels:record.evalueLabel evalueCategory:record.evalueCategory];
}

- (void)doService:(AppointmentRecord *)record {
    
}

- (void)doEvalue:(AppointmentRecord *)record {
    
}

#pragma mark - Action

- (IBAction)actionForAll:(UIButton *)sender {
    if (_orderState == all) {
        return;
    }
    _orderState = all;
    [self selectButton:sender];
    self.params[@"PageIndex"] = @"1";
    self.params[@"IsEnd"] = nil;
    self.params[@"IsPayment"] = nil;
    [_tvRecord.mj_header beginRefreshing];
}
- (IBAction)actionForPlaying:(UIButton *)sender {
    if (_orderState == playing) {
        return;
    }
    _orderState = playing;
    [self selectButton:sender];
    self.params[@"PageIndex"] = @"1";
    self.params[@"IsEnd"] = @"false";
    self.params[@"IsPayment"] = @"true";
    [_tvRecord.mj_header beginRefreshing];
}
- (IBAction)actionForPay:(UIButton *)sender {
    if (_orderState == pay) {
        return;
    }
    _orderState = pay;
    [self selectButton:sender];
    self.params[@"PageIndex"] = @"1";
    self.params[@"IsEnd"] = @"false";
    self.params[@"IsPayment"] = @"false";
    [_tvRecord.mj_header beginRefreshing];
}
- (IBAction)actionForComplete:(UIButton *)sender {
    if (_orderState == complete) {
        return;
    }
    _orderState = complete;
    [self selectButton:sender];
    self.params[@"PageIndex"] = @"1";
    self.params[@"IsEnd"] = @"true";
    self.params[@"IsPayment"] = @"true";
    [_tvRecord.mj_header beginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentRecord *record = _records[indexPath.row];
    static NSString *cellIdentifier = @"";
    AppointmentTableViewCell *cell = nil;
    if (record.isPay == NO) {
        cellIdentifier = @"PayCell";
        PayTableViewCell *payCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell = payCell;        /** 未支付 **/
    } else if (record.isPay == YES && record.isEnd == NO && ![CheckStringManager checkBlankString:record.lastEvlueTime]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *reportDate = [formatter dateFromString:[record.lastEvlueTime substringToIndex:10]];
        if ([reportDate compare:[NSDate date]] == NSOrderedAscending) {
            cellIdentifier = @"OverdueCell";
            OverdueTableViewCell *overdueCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            cell = overdueCell; /** 已回复 **/
        } else {
            cellIdentifier = @"ReviewCell";
            ReviewTableViewCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            cell = reviewCell;  /**  **/
        }
    } else if (record.isEnd == YES && record.isEvalue == YES) {
        cellIdentifier = @"EvalueCell";
        EvalueTableViewCell *evalueCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        evalueCell.indexPath = indexPath;
        __weak typeof(self) ws = self;
        evalueCell.reloadEvalueCell = ^ (CGFloat cellHeight, NSIndexPath *indexPath) {
            _evalueCellHeight = cellHeight;
            __strong typeof(ws) ss = ws;
            [ss tableView:_tvRecord heightForRowAtIndexPath:indexPath];
            [ss->_tvRecord beginUpdates];
            [ss->_tvRecord endUpdates];
        };
        cell = evalueCell;
    } else if (record.isEnd == YES && record.isEvalue == NO) {
        cellIdentifier = @"CompletCell";
        CompletTableViewCell *completCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell = completCell;
    }
    cell.record = record;
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tvRecord cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[EvalueTableViewCell class]]) {
        return _evalueCellHeight;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (void)selectButton:(UIButton *)sender {
    for (UIButton *button in _buttons) {
        button.selected = button == sender;
    }
}

#pragma mark - Evalue expert delegate

- (void)submitEvalue:(NSDictionary *)evalue forRecord:(AppointmentRecord *)record{
    [self saveRecord:record isEnd:record.isEnd ? @"true" : @"false" star:[NSString stringWithFormat:@"%ld", [evalue[EVALUESTARCOUNT] integerValue]] evalue:evalue[EVALUECONTENT] labels:evalue[EVALUELABELS] evalueCategory:evalue[EVALUECATEGORY]];
}

#pragma mark - Appointment cell delegate

- (void)pay:(AppointmentRecord *)record {
    if (_vwEvalue == nil) {
        _vwEvalue = [[[NSBundle mainBundle] loadNibNamed:@"EvalueExpert" owner:self options:nil] lastObject];
        _vwEvalue.delegate = self;
        _vwEvalue.goodEvalueLabels = _goodsEvalues;
        _vwEvalue.badEvalueLabels = _badEvalues;
    }
    _vwEvalue.record = record;
    [_vwEvalue configUI];
    [self.view addSubview:_vwEvalue];
//    PayTableViewController *tvcPay = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcPay"];
//    tvcPay.expert = record.expert;
//    tvcPay.archives = record.reports;
//    tvcPay.birth = record.birthday;
//    tvcPay.reply = record.lastEvlueTime;
//    tvcPay.remark = record.remark;
//    //            tvcPay.orderId = response[@"Id"];
//    NSString *sex = record.sex;
//    tvcPay.sex = sex;
//    NSMutableString *archiveIds = nil;
//    if (record.reports != nil && record.reports.count != 0) {
//        archiveIds = [NSMutableString string];
//        for (int i = 0; i < record.reports.count; i ++) {
//            HealthyArchive *archive = record.reports[i];
//            [archiveIds appendFormat:@"%@;", archive.archiveCode];
//        }
//    }
//    if (archiveIds != nil) {
//        [archiveIds deleteCharactersInRange:NSMakeRange(archiveIds.length - 1, 1)];
//    }
//    tvcPay.archiveIds = archiveIds;
//    [self.navigationController pushViewController:tvcPay animated:YES];
}

- (void)prompt:(AppointmentRecord *)record {
    [[PersonClient shareInstance] remindRecord:record.recordId handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            
        } else {
            
        }
    }];
}

- (void)detail:(AppointmentRecord *)record {
    AppointmentDetailTableViewController *tvcAppointmentDetail = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAppointmentDetail"];
    tvcAppointmentDetail.record = record;
    [self.navigationController pushViewController:tvcAppointmentDetail animated:YES];
}

- (void)complete:(AppointmentRecord *)record {
    if (record.isEvalue) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"确认完成预约" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self doCompleteRecord:record];
        }];
        [ac addAction:cancel];
        [ac addAction:sure];
        [self presentViewController:ac animated:YES completion:nil];
    } else {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"确认完成预约" message:@"您的预约没有任何专家回复，是否确认完成\n确认完成后将无法收到任何专家回复" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"等回复" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"坚持完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self doCompleteRecord:record];
        }];
        [ac addAction:cancel];
        [ac addAction:sure];
        [self presentViewController:ac animated:YES completion:nil];
    }
}

- (void)report:(AppointmentRecord *)record {
    ExpertReviewViewController *vcExpertReview = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"vcExpertReview"];
    vcExpertReview.fromWhere = @"1";
    vcExpertReview.record = record;
    [self.navigationController pushViewController:vcExpertReview animated:YES];
}

- (void)service:(AppointmentRecord *)record {
    
}

- (void)evalue:(AppointmentRecord *)record {
    if (_vwEvalue == nil) {
        _vwEvalue = [[[NSBundle mainBundle] loadNibNamed:@"EvalueExpert" owner:self options:nil] lastObject];
        _vwEvalue.delegate = self;
        _vwEvalue.goodEvalueLabels = _goodsEvalues;
        _vwEvalue.badEvalueLabels = _badEvalues;
    }
    _vwEvalue.record = record;
    [_vwEvalue configUI];
    [self.view addSubview:_vwEvalue];
}

@end
