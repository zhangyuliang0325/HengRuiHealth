//
//  HealthyArchiveViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyArchiveViewController.h"

#import "HealthyArchiveDetailTableViewController.h"

#import "HealthyArchiveListTableViewCell.h"
#import "HealthyArchiveListFooter.h"
#import "BlankHealthyArchiveList.h"
#import "HDDateView.h"

#import "ArchiveClient.h"

#import <MJRefresh/MJRefresh.h>
#import "MBPrograssManager.h"
#import <MJExtension.h>
@interface HealthyArchiveViewController () <UITableViewDelegate, UITableViewDataSource, HealthyArchiveListCellDelegate, BlankHealthyArchiveListDelegate, HDDateViewDelegate> {
    __weak IBOutlet HDDateView *_vwDateFrom;
    __weak IBOutlet HDDateView *_vwDateTo;
    __weak IBOutlet UIButton *_btnAdd;
    __weak IBOutlet UITableView *_tvList;
    
    NSMutableArray *_healthyArchives;
    
    BlankHealthyArchiveList *_blankPage;
    NSInteger _pageNumber;
    NSInteger _limit;
    
    NSDate *_from;
    NSDate *_to;
    CGFloat _dateLead;
    CGFloat _codeLead;
}

@end

@implementation HealthyArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configCompont];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repleaceView) name:kNotificationRepleaceArchiveList object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Http server

- (void)removeArchive:(HealthyArchive *)archive {
    [MBPrograssManager showPrograssOnMainView];
    [[ArchiveClient shareInstance] removeArchive:archive.archiveId handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessage:@"删除成功" OnView:self.view];
            [_healthyArchives removeObject:archive];
            [_tvList reloadData];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

- (void)obtainArchiveListWithPageNumer:(NSInteger)pageNumber limit:(NSInteger)limit {
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId];
    NSString *number = [NSString stringWithFormat:@"%d", (int)pageNumber];
    NSString *min = [NSString stringWithFormat:@"%d", (int)limit];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:ss"];
    NSString *from = nil;
    NSString *to = nil;
    if (_from != nil) {
        from = [format stringFromDate:_from];
    }
    if (_to != nil) {
        to = [format stringFromDate:_to];
    }
    [[ArchiveClient shareInstance] obtainArchiveListForUser:userId pageNumber:number limit:min from:from to:to handler:^(id response, BOOL isSuccess) {
        [self removeBlankPage];
        _tvList.tableHeaderView.hidden = NO;
        if (isSuccess) {
            NSArray *jsons = response[@"Items"];
            NSArray *models = [HealthyArchive mj_objectArrayWithKeyValuesArray:jsons];
            [_healthyArchives addObjectsFromArray:models];
            [self endRefresh];
            [_tvList reloadData];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
            if (_pageNumber > 1) {
                _pageNumber --;
            }
            [_tvList.mj_header endRefreshing];
            [_tvList.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForAddButton:(UIButton *)sender {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAddArchive"] animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _healthyArchives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HealthyArchiveCellIdentifier";
    HealthyArchiveListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.archive = _healthyArchives[indexPath.row];
    cell.dateLead = _dateLead;
    cell.codeLead = _codeLead;
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HealthyArchive *archive = _healthyArchives[indexPath.row];
        [self removeArchive:archive];
    }
}

#pragma mark - Healthy archive cell delegate

- (void)reviewArchive:(HealthyArchive *)archive {
    HealthyArchiveDetailTableViewController *tvcArchiveDetail = [[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchiveDetail"];
    tvcArchiveDetail.archiveId = archive.archiveId;
    [self.navigationController pushViewController:tvcArchiveDetail animated:YES];
}

#pragma mark - Healthy archive footer delegate



#pragma mark - Blank archive delegate {

- (void)addArchiveBlank {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAddArchive"] animated:YES];
}

#pragma mark - Date view delegate

- (void)chooseDate:(NSDate *)date type:(HDDateViewType)type {
    switch (type) {
        case dateViewForm:
            _from = date;
            _dateLead = ((HRHtyScreenWidth - 1) / 2 - _vwDateFrom.textWidth) / 2;
            break;
        case dateViewTo:
            _to = date;
            _codeLead = ((HRHtyScreenWidth - 1) / 2 - _vwDateTo.textWidth) / 2;
            break;
    }
    [_tvList.mj_header beginRefreshing];
}

#pragma mark - UI

- (void)configUI {
    //    _tvList.rowHeight = UITableViewAutomaticDimension;
    //    _tvList.estimatedRowHeight = 70;
    _tvList.tableFooterView = [UIView new];
    [self addRefreshFooter];
    [self addRefreshHeader];
    [_tvList.mj_header beginRefreshing];
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    _tvList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        [ss->_healthyArchives removeAllObjects];
        ss->_pageNumber = 1;
        [ss obtainArchiveListWithPageNumer:_pageNumber limit:_limit];
    }];
};

- (void)addRefreshFooter {
    __weak typeof(self) ws = self;
    _tvList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_pageNumber ++;
        [ss obtainArchiveListWithPageNumer:_pageNumber limit:_limit];
    }];
    [_tvList.mj_footer setAutomaticallyHidden:YES];
}

- (void)endRefresh {
    if ([_tvList.mj_header isRefreshing]) {
        [_tvList.mj_header endRefreshing];
        if (_healthyArchives.count == 0) {
            [self showBlankPage];
            _tvList.tableHeaderView.hidden = YES;
            _tvList.mj_footer.hidden = YES;
        }
    } else {
        if (_healthyArchives.count < (_pageNumber * _limit)) {
            [_tvList.mj_footer endRefreshingWithNoMoreData];
        } else {
            [_tvList.mj_footer endRefreshing];
        }
    }
}

- (void)showBlankPage {
    if (_blankPage == nil) {
        CGFloat h = self.view.bounds.size.height - 5;
        _blankPage = [[[NSBundle mainBundle] loadNibNamed:@"BlankHealthyArchiveList" owner:self options:nil] lastObject];
        _blankPage.delegate = self;
        _blankPage.frame = CGRectMake(0, 5, HRHtyScreenWidth, h);
    }
    
    [self.view addSubview:_blankPage];
}

- (void)removeBlankPage {
    if ([self.view.subviews containsObject:_blankPage]) {
        [_blankPage removeFromSuperview];
    }
}

#pragma mark - Method

- (void)configCompont {
    _limit = 15;
    _healthyArchives = [NSMutableArray array];
    
    _dateLead = ((HRHtyScreenWidth - 1) / 2 - 116) / 2;
    _codeLead = ((HRHtyScreenWidth - 1) / 2 - 116) / 2;
    
    _vwDateFrom.type = dateViewForm;
    _vwDateFrom.delegate = (id)self;
    _vwDateFrom.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"自%@", dateString];
    };
    _vwDateTo.type = dateViewTo;
    _vwDateTo.delegate = (id)self;
    _vwDateTo.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"至%@", dateString];
    };
}

- (void)repleaceView {
    [_vwDateFrom repleaceView];
    [_vwDateTo repleaceView];
    _from = nil;
    _to = nil;
    [_tvList.mj_header beginRefreshing];
}

@end
